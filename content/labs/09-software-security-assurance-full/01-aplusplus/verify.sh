#!/bin/sh
# a = a++; is undefined behaviour; gcc yields a=1. Show it compiles and runs.
set -e
gcc -o /tmp/aplusplus aplusplus.c 2>/dev/null
out=$(/tmp/aplusplus); rm -f /tmp/aplusplus
echo "$out"
echo "$out" | grep -q '^a=1$' || { echo "FAIL: expected a=1"; exit 1; }
echo "OK: a = a++ (UB) yields a=1 under gcc"
