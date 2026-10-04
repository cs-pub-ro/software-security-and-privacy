#!/usr/bin/env bash
#
# Verify one binary CTF challenge end to end, entirely in containers:
#
#     build  -> compile the 32-bit binary from source
#     publish-> place the artifact where deploy expects it
#     deploy -> serve it over TCP with xinetd, on a throwaway bridge network
#     solve  -> run the reference exploit against that deployment
#
# The reference exploit (solve/exploit.py) is authoritative: it asserts its own
# success and exits 0 when the challenge is solved. This script keys off that
# exit code, so it works both for flag-bearing challenges (the exploit captures
# SSP{...}) and for control-flow challenges that have no flag to capture.
#
# Usage:
#   dev/verify/ctf.sh <challenge-dir> [--flag 'SSP{...}'] [--keep]
#
# Exit status: 0 if the exploit solved the challenge, 1 otherwise.

set -euo pipefail

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

keep=0
flag="SSP{verify_$(date +%s)_$RANDOM}"
chal_arg=""

while [ $# -gt 0 ]; do
	case "$1" in
	--keep) keep=1; shift ;;
	--flag) flag=$2; shift 2 ;;
	-h|--help) sed -n '2,20p' "$0"; exit 0 ;;
	-*) fail "unknown option: $1"; exit 2 ;;
	*) chal_arg=$1; shift ;;
	esac
done

[ -n "$chal_arg" ] || { fail "no challenge directory given"; exit 2; }
require_docker

chal=$(cd "$chal_arg" && pwd)
name=$(basename "$chal")
deploy_df="$chal/deploy/Dockerfile"
xinetd="$chal/deploy/xinetd.conf"

for d in build publish deploy solve; do
	[ -d "$chal/$d" ] || { fail "$name: missing $d/"; exit 2; }
done

exec_name=$(dockerfile_arg "$deploy_df" EXEC_NAME); exec_name=${exec_name:-vuln}
chal_name=$(dockerfile_arg "$deploy_df" CHALLENGE_NAME); chal_name=${chal_name:-$name}
port=$(xinetd_port "$xinetd"); port=${port:-31337}

# Everything this run creates is tagged with a unique id, so parallel or
# interrupted runs never collide and cleanup is exact.
run="ssp-$name-$$"
net="$run-net"
deploy_ctr="deploy"            # the name the solver connects to on the network
builder_img="$run-builder"
deploy_img="$run-deploy"
solver_img="$run-solver"

cleanup() {
	[ "$keep" = 1 ] && { warn "--keep: leaving $net and images in place"; return; }
	docker rm -f "$run-deploy-ctr" >/dev/null 2>&1 || true
	docker network rm "$net" >/dev/null 2>&1 || true
	docker rmi "$builder_img" "$deploy_img" "$solver_img" >/dev/null 2>&1 || true
}
trap cleanup EXIT

log ""
step "$name  (exec=$exec_name, port=$port)"

# 1. Build the binary.
if [ -f "$chal/build/Makefile" ]; then
	step "build: compiling $exec_name"
	docker build -q -t "$builder_img" "$chal/build" >/dev/null
	docker run --rm -v "$chal/build:/build" "$builder_img" make >&2
	[ -f "$chal/build/$exec_name" ] || { fail "build produced no $exec_name"; exit 1; }
	# 2. Publish the artifact where deploy's build context expects it.
	cp "$chal/build/$exec_name" "$chal/publish/$exec_name"
else
	fail "$name: no build/Makefile -- challenge has no build recipe yet"
	exit 1
fi

# 3. Deploy on a private bridge network.
step "deploy: building image and starting container"
docker build -q -t "$deploy_img" -f "$deploy_df" \
	--build-arg FLAG="$flag" \
	--build-arg EXEC_NAME="$exec_name" \
	--build-arg CHALLENGE_NAME="$chal_name" \
	"$chal" >/dev/null
docker network create "$net" >/dev/null
docker run -d --rm --name "$run-deploy-ctr" --network "$net" \
	--network-alias "$deploy_ctr" "$deploy_img" >/dev/null
# xinetd is up almost immediately; give it a moment before the first connect.
sleep 2

# 4. Solve against the deployment.
step "solve: running the reference exploit"
docker build -q -t "$solver_img" "$chal/solve" >/dev/null
set +e
out=$(docker run --rm --network "$net" \
	-v "$chal:/work" -w /work/publish \
	"$solver_img" python3 /work/solve/exploit.py \
	REMOTE "HOST=$deploy_ctr" "PORT=$port" 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2

if [ "$rc" -eq 0 ]; then
	# For flag-bearing challenges, confirm the planted flag really came back.
	if printf '%s' "$out" | grep -qF "$flag"; then
		pass "$name: exploit captured the planted flag"
	else
		pass "$name: exploit reported success (no flag to capture)"
	fi
	exit 0
else
	fail "$name: exploit exited $rc"
	exit 1
fi
