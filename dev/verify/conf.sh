#!/usr/bin/env bash
#
# Verify a local application-confinement challenge (session 07) by running its
# verify.sh in a container with the build toolchain and the capabilities the
# mechanism needs (ptrace for strace, sys_chroot for the chroot jail).
#
# These are build-and-observe exercises, not flag CTFs: verify.sh builds the
# program and checks the confinement mechanism behaves (exit 0 on success).
# AppArmor cannot be enforced in this sandbox (no host LSM); its verify.sh only
# syntax-checks the profile.
#
# Usage: dev/verify/conf.sh <challenge-dir>
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=dev/verify/lib.sh
. "$HERE/lib.sh"

[ $# -ge 1 ] || { fail "no challenge directory given"; exit 2; }
chal=$(cd "$1" && pwd); name=$(basename "$chal")
[ -x "$chal/verify.sh" ] || { fail "$name: no executable verify.sh"; exit 2; }
require_docker

img="ssp-conf-runner"
docker build -q -t "$img" - >/dev/null <<'DF'
FROM debian:13
RUN dpkg --add-architecture i386 \
 && apt-get -yqq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends \
        make gcc-multilib nasm binutils strace libseccomp-dev:i386 \
        libc6-i386 apparmor-utils \
 && rm -rf /var/lib/apt/lists/*
DF

log ""
step "$name (confinement): running verify.sh"
set +e
out=$(docker run --rm --cap-add=SYS_PTRACE --cap-add=SYS_CHROOT \
	-v "$chal:/c" -w /c "$img" bash ./verify.sh 2>&1)
rc=$?
set -e
printf '%s\n' "$out" >&2
if [ "$rc" -eq 0 ]; then pass "$name: verify.sh succeeded"; exit 0; fi
fail "$name: verify.sh failed (exit $rc)"; exit 1
