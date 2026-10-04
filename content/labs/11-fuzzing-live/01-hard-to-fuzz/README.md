# Exercise: Hard to Fuzz

**Tools:** clang, libFuzzer

## Goal

Fuzz `fuzzy` until it crashes, and understand why a naive fuzzer struggles to reach the bug.

## Background

`fuzzy.c` guards its bug behind a check (such as a magic value or a checksum) that random input almost never satisfies, which is what makes it "hard to fuzz".
`fuzzer.cpp` is the libFuzzer harness; `crash-me.c` reproduces a crash from a saved input.

## Your Task

1. Build with `make` (the harness links clang's built-in libFuzzer via `-fsanitize=fuzzer`).
1. Run `./fuzzy-fuzzer` and watch whether it finds a crash.
1. Read `fuzzy.c`, identify the guard, and help the fuzzer past it (for example a seed corpus or a dictionary).

## Build & Run

```console
make
./fuzzy-fuzzer
```

## Check Your Work

The fuzzer should eventually report a crash and save the input.
Be ready to explain what blocked it and how coverage feedback helped once it got past the guard.
