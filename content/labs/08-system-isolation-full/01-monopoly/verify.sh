#!/bin/sh
# chroot is not a privilege boundary: a root process can re-chroot into a
# subdirectory while holding a descriptor to the old root, chdir up past it, and
# chroot back to the real root. umount.c is that escape. We set up a minimal
# jail (no bind mounts needed -- just the escape binary and its libraries),
# plant a real /flag outside it, and show the escaped shell reads it.
set -e
flag="SSP{monopoly_$(head -c6 /dev/urandom | od -An -tx1 | tr -d ' \n')}"
printf '%s\n' "$flag" > /flag

gcc -o umount umount.c 2>/dev/null
rm -rf jail; mkdir -p jail
cp umount jail/
# the escape binary needs its loader + libc inside the jail to start
for f in $(ldd umount | grep -oE '/[^ ]+'); do
    mkdir -p "jail$(dirname "$f")"; cp "$f" "jail$f" 2>/dev/null || true
done

# Inside the jail, /umount escapes to the real root and execs an interactive
# shell; feed it a command to read the real /flag.
out=$(printf 'cat /flag\n' | chroot jail /umount 2>&1 || true)
rm -rf jail umount /flag
printf '%s\n' "$out" | tr -d '\r'
printf '%s' "$out" | grep -q "$flag" || { echo "FAIL: escape did not reach the real /flag"; exit 1; }
echo "OK: escaped the root chroot jail and read the real /flag"
