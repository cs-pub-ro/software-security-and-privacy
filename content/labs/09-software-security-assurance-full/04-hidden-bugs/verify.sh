#!/bin/sh
# Eight planted bugs; the point is what each static analyzer catches. Run all
# three and require each to report findings.
set -e
echo "=== flawfinder ==="
fw=$(flawfinder --quiet hidden-bugs.c 2>/dev/null || true); echo "$fw" | grep -E 'Hits|:[0-9]+:' | head -8
echo "=== cppcheck ==="
cc=$(cppcheck --enable=warning,style,portability --inline-suppr hidden-bugs.c 2>&1 || true); echo "$cc" | grep -E 'warning|error|style' | head -8
echo "=== clang-tidy ==="
ct=$(clang-tidy hidden-bugs.c -- 2>/dev/null || true); echo "$ct" | grep -E 'warning:|error:' | head -8

fail=0
echo "$fw" | grep -qE ':[0-9]+:.*\[' || { echo "FAIL: flawfinder found nothing"; fail=1; }
echo "$cc" | grep -qE 'warning|error|style'  || { echo "FAIL: cppcheck found nothing"; fail=1; }
echo "$ct" | grep -qE 'warning:|error:'       || { echo "FAIL: clang-tidy found nothing"; fail=1; }
[ "$fail" = 0 ] && echo "OK: all three analyzers flag bugs in the code" || exit 1
