#!/usr/bin/env bash
#
# Verify an HTTP CTF challenge end to end, in containers:
#
#   deploy -> build the web image (flag planted) and run it
#   solve  -> run solve/extract against it; the script recovers the flag over
#             HTTP and asserts success itself (exit 0 and prints SSP{...}).
#
# The deploy builds from the challenge-root context with -f deploy/Dockerfile.
# A fresh flag (and DB password, where used) is planted into a throwaway copy,
# so committed files are untouched.
#
# Usage: dev/verify/http.sh <challenge-dir> [--keep]
# Exit status: 0 if the solve recovered the flag, 1 otherwise.

set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

keep=0; chal_arg=""
while [ $# -gt 0 ]; do
	case "$1" in
	--keep) keep=1; shift ;;
	-*) fail "unknown option: $1"; exit 2 ;;
	*) chal_arg=$1; shift ;;
	esac
done
[ -n "$chal_arg" ] || { fail "no challenge directory given"; exit 2; }
require_docker

chal=$(cd "$chal_arg" && pwd); name=$(basename "$chal")
[ -f "$chal/deploy/Dockerfile" ] || { fail "$name: no deploy/Dockerfile"; exit 2; }
[ -x "$chal/solve/extract" ] || { fail "$name: no executable solve/extract"; exit 2; }

flag="SSP{verify_$(date +%s)_$RANDOM}"
dbpw="verifypw_$RANDOM"
run="http-$name-$$"; net="$run-net"; img="$run-img"; ctr="$run-ctr"
solver="ssp-http-solver"
tmp=$(mktemp -d)

cleanup() {
	[ "$keep" = 1 ] && { warn "--keep: leaving $ctr/$net up; context in $tmp"; return; }
	docker rm -f "$ctr" >/dev/null 2>&1 || true
	docker network rm "$net" >/dev/null 2>&1 || true
	docker rmi "$img" >/dev/null 2>&1 || true
	rm -rf "$tmp"
}
trap cleanup EXIT

log ""
step "$name (http): planting flag and building"
cp -r "$chal/." "$tmp/"
printf '%s\n' "$flag" > "$tmp/flag"
# Challenges that keep the flag in a seeded database or page carry a
# placeholder; plant the real flag there too.
for f in $(grep -rl 'SSP{placeholder}' "$tmp/deploy" 2>/dev/null || true); do
	sed -i "s/SSP{placeholder}/$flag/g" "$f"
done
# Plant deployment secrets where the challenge uses them.
for f in "$tmp"/deploy/setup "$tmp"/deploy/sql "$tmp"/deploy/login.php "$tmp"/deploy/Dockerfile; do
	[ -f "$f" ] && sed -i "s/CTF_DB_ROOT_PASSWORD/$dbpw/g; s/CTF_DB_PASSWORD/$dbpw/g" "$f"
done
docker build -q -t "$img" -f "$tmp/deploy/Dockerfile" "$tmp" >/dev/null

step "deploy: starting the web container"
docker network create "$net" >/dev/null
docker run -d --rm --name "$ctr" --network "$net" --network-alias web "$img" >/dev/null

docker build -q -t "$solver" - >/dev/null <<'DF'
FROM debian:12-slim
RUN apt-get -yqq update && apt-get -yqq install --no-install-recommends curl ca-certificates >/dev/null && rm -rf /var/lib/apt/lists/*
DF

step "waiting for the app"
ready=0
for _ in $(seq 1 40); do
	if docker run --rm --network "$net" "$solver" curl -fs -o /dev/null "http://web:80/"; then
		ready=1; break
	fi
	sleep 2
done
[ "$ready" = 1 ] || { fail "$name: the app did not come up"; exit 1; }

step "solve: running the reference extract"
set +e
out=$(docker run --rm --network "$net" -v "$chal/solve:/solve" -w /solve \
	-e CTF_HOST=web -e CTF_PORT=80 "$solver" bash /solve/extract 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2

if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -qF "$flag"; then
	pass "$name: extract recovered the planted flag"
	exit 0
fi
fail "$name: extract did not recover the flag (exit $rc)"
exit 1
