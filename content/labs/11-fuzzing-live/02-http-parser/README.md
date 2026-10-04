# Exercise: HTTP Parser

**Tools:** clang, libFuzzer

## Goal

Fuzz a real HTTP parser and triage what you find.

## Background

`utils/http_parser.c` is a widely used C HTTP parser (third-party, vendored here).
`fuzzer.cpp` feeds fuzzer input into it; `crash-me.c` replays a saved input.

## Your Task

1. Build with `make` and run `./fuzzer`.
1. When it finds a crashing input, reproduce it with `crash-me` and read the parser code around the fault.
1. Decide whether each finding is a real bug or a harness artefact.

## Build & Run

```console
make
./fuzzer
```

## Check Your Work

Be ready to explain one crash: the input, the code path, and whether it is exploitable or benign.
