#!/bin/sh
# The shellcode writes a banner and then makes two open() calls (a.txt, b.txt) --
# this is the program the confinement tasks restrict. strace must show both.
set -e
make -C run-shellcode clean >/dev/null 2>&1 || true
make -C run-shellcode >/dev/null
out=$(cd run-shellcode && timeout 10 strace -f -e trace=open,openat ./exec 2>&1 || true)
make -C run-shellcode clean >/dev/null 2>&1 || true
echo "$out" | grep -E 'open.*"a\.txt"' | head -1
echo "$out" | grep -E 'open.*"b\.txt"' | head -1
echo "$out" | grep -q 'Hello, World!' || { echo "FAIL: banner not printed"; exit 1; }
echo "$out" | grep -Eq 'open.*"a\.txt"' || { echo "FAIL: no open(a.txt)"; exit 1; }
echo "$out" | grep -Eq 'open.*"b\.txt"' || { echo "FAIL: no open(b.txt)"; exit 1; }
echo "OK: shellcode prints banner and opens a.txt and b.txt"
