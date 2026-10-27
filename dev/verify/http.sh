#!/usr/bin/env bash
#
# Verify one HTTP CTF challenge end to end, entirely in containers:
#
#   deploy -> build deploy/Dockerfile (challenge-root context) with a fresh
#             random flag and DB passwords, and run it on a throwaway network
#   solve  -> run solve/exploit.py in the solve/ image against it
#
# The flag and passwords go in as the same build args ssp-deploy.py passes
# (FLAG_PATHS/FLAG_VALUES, DB_ROOT_PASSWORD, DB_PASSWORD), so committed files
# are untouched. Because the flag is random, a pass proves the exploit really
# pulled it out of the deployment.
#
# Usage: dev/verify/http.sh <challenge-dir> [--flag 'SSP{...}'] [--keep]
# Exit status: 0 if the exploit recovered the planted flag, 1 otherwise.

set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

keep=0; chal_arg=""
flag="SSP{verify_$(date +%s)_$RANDOM}"
while [ $# -gt 0 ]; do
	case "$1" in
	--keep) keep=1; shift ;;
	--flag) flag=$2; shift 2 ;;
	-h|--help) sed -n '2,15p' "$0"; exit 0 ;;
	-*) fail "unknown option: $1"; exit 2 ;;
	*) chal_arg=$1; shift ;;
	esac
done
[ -n "$chal_arg" ] || { fail "no challenge directory given"; exit 2; }
require_docker

chal=$(cd "$chal_arg" && pwd); name=$(basename "$chal")
for f in deploy/Dockerfile solve/Dockerfile solve/exploit.py; do
	[ -f "$chal/$f" ] || { fail "$name: missing $f"; exit 2; }
done

dbpw="verifypw_$RANDOM"
run="ssp-http-$name-$$"; net="$run-net"; ctr="$run-ctr"
deploy_img="$run-deploy"; solver_img="$run-solver"

# shellcheck disable=SC2329  # invoked via trap
cleanup() {
	[ "$keep" = 1 ] && { warn "--keep: leaving $ctr on $net"; return; }
	docker rm -f "$ctr" >/dev/null 2>&1 || true
	docker network rm "$net" >/dev/null 2>&1 || true
	docker rmi "$deploy_img" "$solver_img" >/dev/null 2>&1 || true
}
trap cleanup EXIT

log ""
step "$name (http): building the deployment with a planted flag"
docker build -q -t "$deploy_img" -f "$chal/deploy/Dockerfile" \
	--build-arg FLAG_PATHS=/flag --build-arg FLAG_VALUES="$flag" \
	--build-arg DB_ROOT_PASSWORD="$dbpw" --build-arg DB_PASSWORD="$dbpw" \
	"$chal" >/dev/null

step "deploy: starting the web container"
docker network create "$net" >/dev/null
docker run -d --name "$ctr" --network "$net" --network-alias web "$deploy_img" >/dev/null

step "solve: building the solve image"
docker build -q -t "$solver_img" "$chal/solve" >/dev/null

step "waiting for the app"
ready=0
for _ in $(seq 1 40); do
	if docker run --rm --network "$net" "$solver_img" python3 -c \
		'import urllib.request; urllib.request.urlopen("http://web:80/", timeout=3)' \
		>/dev/null 2>&1; then
		ready=1; break
	fi
	sleep 2
done
[ "$ready" = 1 ] || { fail "$name: the app did not come up"; exit 1; }

# A web server can answer before its database is up, so retry a few times.
step "solve: running the reference exploit"
rc=1; out=""
for attempt in 1 2 3 4 5; do
	set +e
	out=$(docker run --rm --network "$net" -v "$chal/solve:/solve:ro" -w /solve \
		"$solver_img" python3 /solve/exploit.py --host web --port 80 2>&1)
	rc=$?
	set -e
	if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -qF "$flag"; then
		break
	fi
	[ "$attempt" -lt 5 ] && sleep 3
done
printf '%s\n' "$out" >&2

if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -qF "$flag"; then
	pass "$name: exploit recovered the planted flag"
	exit 0
fi
fail "$name: exploit did not recover the planted flag (exit $rc)"
exit 1
