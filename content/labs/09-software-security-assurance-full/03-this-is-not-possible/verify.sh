#!/bin/sh
# strtof("NAN") gives NaN, which is neither >=0 nor <0, so the "impossible"
# else branch runs (and would spawn a shell). Feed EOF so the shell exits.
set -e
gcc -o /tmp/tinp this_is_not_possible.c 2>/dev/null
out=$(/tmp/tinp NAN </dev/null 2>&1 || true); rm -f /tmp/tinp
echo "$out"
echo "$out" | grep -q "Ah... Just perfect!" || { echo "FAIL: NaN did not reach the else branch"; exit 1; }
echo "OK: NaN reaches the 'impossible' branch (NaN compares false both ways)"
