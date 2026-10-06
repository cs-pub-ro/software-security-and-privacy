#!/bin/sh
# The strcpy overflow in checkcrc hides behind a guard (>=20 uppercase bytes
# whose CheckByte == 0xAD6D) that blind fuzzing rarely satisfies. crash.bin is
# such an input -- the kind a seed or dictionary would feed the fuzzer. libFuzzer
# + ASan replay it and report the buffer overflow.
set -e
make >/dev/null 2>&1
out=$(./fuzzy-fuzzer crash.bin 2>&1 || true)
make clean >/dev/null 2>&1; rm -f crash-[0-9a-f]* 2>/dev/null
echo "$out" | grep -E 'AddressSanitizer|overflow|SUMMARY' | head -2
echo "$out" | grep -q 'AddressSanitizer' || { echo "FAIL: ASan did not report the overflow"; exit 1; }
echo "OK: libFuzzer+ASan detects the guarded buffer overflow"
