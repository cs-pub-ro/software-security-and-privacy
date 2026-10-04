#!/usr/bin/env bash
#
# Verify a local (non-networked) challenge by running its verify.sh inside a
# Python container with the challenge mounted. verify.sh runs the reference
# attack/solution and exits 0 on success.
#
# Usage: dev/verify/local.sh <challenge-dir>
# Exit status: 0 if verify.sh succeeded, 1 otherwise.

set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

[ $# -ge 1 ] || { fail "no challenge directory given"; exit 2; }
chal=$(cd "$1" && pwd); name=$(basename "$chal")
[ -x "$chal/verify.sh" ] || { fail "$name: no executable verify.sh"; exit 2; }
require_docker

# Mount the repo root so a challenge's verify.sh may reach sibling data (e.g. a
# reference solution in -full reading the player data in -live).
root=$(cd "$HERE/../.." && pwd)
rel=${chal#"$root"/}

img="ssp-local-runner"
# A small Python image with the libraries the local challenges use.
docker build -q -t "$img" - >/dev/null <<'DF'
FROM python:3.11-slim
RUN pip install --no-cache-dir pexpect >/dev/null
DF

log ""
step "$name (local): running verify.sh"
set +e
out=$(docker run --rm -e PYTHONDONTWRITEBYTECODE=1 -v "$root:/repo" -w "/repo/$rel" \
	"$img" bash ./verify.sh 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2
if [ "$rc" -eq 0 ]; then
	pass "$name: verify.sh succeeded"
	exit 0
fi
fail "$name: verify.sh failed (exit $rc)"
exit 1
