#!/bin/sh
# run() memcpy's the input into a fixed MAX_LEN (4096) stack buffer with no
# bound check; any longer input overflows it. libFuzzer finds this quickly once
# inputs exceed MAX_LEN; here we feed a >4096-byte input and ASan reports it.
set -e
make >/dev/null 2>&1
head -c 5000 /dev/zero | tr '\0' 'A' > /tmp/big
out=$(./fuzzer /tmp/big 2>&1 || true)
make clean >/dev/null 2>&1; rm -f crash-[0-9a-f]* /tmp/big 2>/dev/null
echo "$out" | grep -E 'AddressSanitizer|overflow|SUMMARY' | head -2
echo "$out" | grep -q 'AddressSanitizer' || { echo "FAIL: ASan did not report the overflow"; exit 1; }
echo "OK: libFuzzer+ASan detects the stack-buffer-overflow in run()"
