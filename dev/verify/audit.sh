#!/usr/bin/env bash
#
# Verify a code-audit challenge (session 09) by running its verify.sh in a
# container with a C toolchain and the static analyzers (cppcheck, flawfinder,
# clang-tidy). These are read-and-analyse exercises: verify.sh compiles/runs the
# demo to show the behaviour, or runs the analyzers to show what they catch.
#
# Usage: dev/verify/audit.sh <challenge-dir>
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

[ $# -ge 1 ] || { fail "no challenge directory given"; exit 2; }
chal=$(cd "$1" && pwd); name=$(basename "$chal")
[ -x "$chal/verify.sh" ] || { fail "$name: no executable verify.sh"; exit 2; }
require_docker

img="ssp-audit-runner"
docker build -q -t "$img" - >/dev/null <<'DF'
FROM debian:13
RUN apt-get -yqq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends \
        build-essential cppcheck flawfinder clang-tidy \
 && rm -rf /var/lib/apt/lists/*
DF

log ""
step "$name (code audit): running verify.sh"
set +e
out=$(docker run --rm -v "$chal:/c" -w /c "$img" bash ./verify.sh 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2
if [ "$rc" -eq 0 ]; then pass "$name: verify.sh succeeded"; exit 0; fi
fail "$name: verify.sh failed (exit $rc)"; exit 1
