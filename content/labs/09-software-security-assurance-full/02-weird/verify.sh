#!/bin/sh
# b = a++ + ++a + a++; is undefined (no sequence points); gcc yields a=4, b=7.
set -e
gcc -o /tmp/weird weird.c 2>/dev/null
out=$(/tmp/weird); rm -f /tmp/weird
echo "$out"
echo "$out" | grep -q '^a=4$' && echo "$out" | grep -q '^b=7$' || { echo "FAIL: expected a=4,b=7"; exit 1; }
echo "OK: unsequenced increments (UB) yield a=4, b=7 under gcc"
