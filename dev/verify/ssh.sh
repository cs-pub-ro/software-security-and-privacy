#!/usr/bin/env bash
#
# Verify an SSH-login CTF challenge end to end, in containers:
#
#   deploy -> build the sshd image (flag and password planted) and run it
#   solve  -> run solve/extract against it; the script logs in as ctf and
#             recovers the flag, asserting success itself (exit 0).
#
# The deploy builds from the challenge-root context with -f deploy/Dockerfile.
# A fresh flag and password are planted into a throwaway copy of the challenge,
# so committed files are untouched.
#
# Usage: dev/verify/ssh.sh <challenge-dir> [--keep]
# Exit status: 0 if the solve recovered the flag, 1 otherwise.

set -euo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

keep=0; chal_arg=""
while [ $# -gt 0 ]; do
	case "$1" in
	--keep) keep=1; shift ;;
	-h|--help) sed -n '2,16p' "$0"; exit 0 ;;
	-*) fail "unknown option: $1"; exit 2 ;;
	*) chal_arg=$1; shift ;;
	esac
done
[ -n "$chal_arg" ] || { fail "no challenge directory given"; exit 2; }
require_docker

chal=$(cd "$chal_arg" && pwd)
name=$(basename "$chal")
[ -f "$chal/deploy/Dockerfile" ] || { fail "$name: no deploy/Dockerfile"; exit 2; }
[ -x "$chal/solve/extract" ] || { fail "$name: no executable solve/extract"; exit 2; }

flag="SSP{verify_$(date +%s)_$RANDOM}"
pw="verifypw_$RANDOM"
run="ssh-$name-$$"
net="$run-net"
img="$run-img"
solver_img="ssp-ssh-solver"
ctr="$run-ctr"
tmp=$(mktemp -d)

# Challenges that hand a capability to a tool need that capability at runtime.
caps=()
if grep -q 'setcap' "$chal/deploy/setup" 2>/dev/null; then
	caps=(--cap-add=cap_dac_read_search)
fi

# shellcheck disable=SC2329  # invoked via trap
cleanup() {
	[ "$keep" = 1 ] && { warn "--keep: leaving $ctr/$net up; context in $tmp"; return; }
	docker rm -f "$ctr" >/dev/null 2>&1 || true
	docker network rm "$net" >/dev/null 2>&1 || true
	docker rmi "$img" >/dev/null 2>&1 || true
	rm -rf "$tmp"
}
trap cleanup EXIT

log ""
step "$name (ssh): planting flag + password and building"
cp -r "$chal/." "$tmp/"
printf '%s\n' "$flag" > "$tmp/flag"
sed -i "s/CTF_PASSWORD/$pw/g" "$tmp/deploy/setup"
docker build -q -t "$img" -f "$tmp/deploy/Dockerfile" "$tmp" >/dev/null

step "deploy: starting the sshd container ${caps[*]:-}"
docker network create "$net" >/dev/null
docker run -d --rm "${caps[@]}" --name "$ctr" --network "$net" \
	--network-alias target "$img" >/dev/null

# Build the solver image (ssh client + sshpass).
docker build -q -t "$solver_img" - >/dev/null <<'DF'
FROM ubuntu:22.04
RUN apt-get -yqq update && apt-get -yqq install openssh-client sshpass >/dev/null
DF

# Wait for sshd to accept connections.
step "waiting for sshd"
ready=0
for _ in $(seq 1 30); do
	if docker run --rm --network "$net" "$solver_img" \
		sshpass -p "$pw" ssh -o StrictHostKeyChecking=no \
		-o UserKnownHostsFile=/dev/null -o ConnectTimeout=3 \
		-o LogLevel=ERROR ctf@target true 2>/dev/null; then
		ready=1; break
	fi
	sleep 2
done
[ "$ready" = 1 ] || { fail "$name: sshd did not come up"; exit 1; }

step "solve: running the reference extract"
set +e
out=$(docker run --rm --network "$net" -v "$chal/solve:/solve" -w /solve \
	-e CTF_HOST=target -e CTF_PORT=22 -e CTF_PASSWORD="$pw" \
	"$solver_img" bash /solve/extract 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2

# The extract is authoritative: it asserts its own success and exits 0. Some
# challenges recover the planted SSP{...} flag; others (where the real secret is
# a hash to crack offline) only prove the access primitive and have no flag to
# echo. Either way exit 0 is the verdict.
if [ "$rc" -eq 0 ]; then
	if printf '%s' "$out" | grep -qF "$flag"; then
		pass "$name: extract recovered the planted flag"
	else
		pass "$name: extract succeeded (no planted flag to echo)"
	fi
	exit 0
fi
fail "$name: extract failed (exit $rc)"
exit 1
