#!/usr/bin/env bash
#
# Verify a web CTF challenge end to end, in containers:
#
#   deploy -> docker compose brings up the app and its database
#   solve  -> run solve/exploit.py against the app on the compose network
#
# The exploit asserts its own success (it captures the planted SSP{...} flag)
# and its exit code is the verdict.
#
# Usage: dev/verify/web.sh <challenge-dir> [--keep]
# Exit status: 0 if the exploit solved the challenge, 1 otherwise.

set -euo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

keep=0
chal_arg=""
while [ $# -gt 0 ]; do
	case "$1" in
	--keep) keep=1; shift ;;
	-h|--help) sed -n '2,15p' "$0"; exit 0 ;;
	-*) fail "unknown option: $1"; exit 2 ;;
	*) chal_arg=$1; shift ;;
	esac
done
[ -n "$chal_arg" ] || { fail "no challenge directory given"; exit 2; }
require_docker

chal=$(cd "$chal_arg" && pwd)
name=$(basename "$chal")
compose="$chal/deploy/docker-compose.yml"
[ -f "$compose" ] || { fail "$name: no deploy/docker-compose.yml"; exit 2; }

flag="SSP{verify_$(date +%s)_$RANDOM}"
proj="ssp-web-${name}-$$"
solver_img="$proj-solver"
net="${proj}_default"

# shellcheck disable=SC2329  # invoked via trap
cleanup() {
	[ "$keep" = 1 ] && { warn "--keep: leaving compose project $proj up"; return; }
	FLAG="$flag" DB_PASSWORD="verifypw" \
		docker compose -p "$proj" -f "$compose" down -v --remove-orphans >/dev/null 2>&1 || true
	docker rmi "$solver_img" >/dev/null 2>&1 || true
}
trap cleanup EXIT

log ""
step "$name (web): building and starting the deployment"
FLAG="$flag" DB_PASSWORD="verifypw" \
	docker compose -p "$proj" -f "$compose" up -d --build >&2

# Wait for the web service to answer.
step "waiting for the app to come up"
ready=0
for _ in $(seq 1 40); do
	if docker run --rm --network "$net" curlimages/curl:latest \
		-fs -o /dev/null "http://web:80/index.php"; then
		ready=1; break
	fi
	sleep 2
done
[ "$ready" = 1 ] || { fail "$name: the app did not come up"; exit 1; }

step "solve: running the reference exploit"
docker build -q -t "$solver_img" "$chal/solve" >/dev/null
set +e
out=$(docker run --rm --network "$net" -v "$chal/solve:/solve" -w /solve \
	"$solver_img" python3 /solve/exploit.py HOST=web PORT=80 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2

if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -qF "$flag"; then
	pass "$name: exploit captured the planted flag"
	exit 0
fi
fail "$name: exploit did not capture the planted flag (exit $rc)"
exit 1
