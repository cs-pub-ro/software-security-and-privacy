# Hard to Fuzz

## Goal

Reach the bug in `fuzzy` that a guard hides from random input.

## Solution

`fuzzy.c` gates the bug behind a check that blind fuzzing rarely satisfies; the way through is to give the fuzzer help (a seed input or a dictionary of the magic bytes) so coverage feedback can then drive it to the fault.
The harness uses clang's built-in libFuzzer (`-fsanitize=fuzzer`).
See the [task](../../11-fuzzing-live/01-hard-to-fuzz/README.md).
