#!/bin/sh
# seccomp allows read+write on a.txt but only read on b.txt: observe the write
# syscalls under strace -- the a.txt fd write succeeds, the b.txt fd write is
# blocked by the filter (returns an error).
set -e
make clean >/dev/null 2>&1 || true
make >/dev/null
out=$(timeout 10 strace -f -e trace=write ./exec 2>&1 || true)
make clean >/dev/null 2>&1 || true
echo "$out" | grep -E 'write\(3, .*\) +=' | head -1
echo "$out" | grep -E 'write\(4, .*\) +=' | head -1
echo "$out" | grep -Eq 'write\(3, .*\) += 3'  || { echo "FAIL: a.txt write not allowed"; exit 1; }
echo "$out" | grep -Eq 'write\(4, .*\) += -1' || { echo "FAIL: b.txt write not blocked"; exit 1; }
echo "OK: seccomp allows write(a.txt), blocks write(b.txt)"
