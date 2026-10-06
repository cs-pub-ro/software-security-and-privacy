#!/bin/sh
# chroot restricts the filesystem view: a.txt inside the jail opens, but ../b.txt
# cannot escape the jail to reach the real b.txt outside it.
set -e
make clean >/dev/null 2>&1 || true
make >/dev/null
rm -rf jail; mkdir -p jail
cp exec a.txt jail/
# copy the shared libraries (and loader) the binary needs into the jail
for f in $(ldd exec | grep -oE '/[^ ]+'); do
    mkdir -p "jail$(dirname "$f")"; cp "$f" "jail$f" 2>/dev/null || true
done
out=$(chroot jail /exec 2>&1 || true)
rm -rf jail; make clean >/dev/null 2>&1 || true
printf '%s\n' "$out"
echo "$out" | grep -q 'Could not open file a.txt'   && { echo "FAIL: a.txt not reachable in jail"; exit 1; }
echo "$out" | grep -q 'Could not open file ../b.txt' || { echo "FAIL: ../b.txt was reachable (not confined)"; exit 1; }
echo "OK: chroot confines -- a.txt opens in the jail, ../b.txt is unreachable"
