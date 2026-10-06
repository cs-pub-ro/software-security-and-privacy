#!/bin/sh
# Both swaps are correct for distinct variables (swap_temp swaps a,b; swap_xor
# swaps them back to the originals). The XOR swap's correctness assumes a and b
# do not alias -- swap_xor(&c,&c) zeroes c, the input that breaks it.
set -e
gcc -g -O2 -o /tmp/swapper swapper.c
out=$(/tmp/swapper); rm -f /tmp/swapper
echo "$out"
echo "$out" | grep -q 'After swap_temp: a = babecafec0de, b = deadbeefcafe' || { echo "FAIL: swap_temp wrong"; exit 1; }
echo "$out" | grep -q 'After swap_xor: a = deadbeefcafe, b = babecafec0de'  || { echo "FAIL: swap_xor wrong"; exit 1; }
echo "$out" | grep -q 'After swap_xor(&c, &c): c = 0'                       || { echo "FAIL: aliasing case did not zero c"; exit 1; }
echo "OK: both swaps correct for distinct vars; XOR swap breaks (zeroes) under aliasing"
