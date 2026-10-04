# HTTP Parser

## Goal

Fuzz the vendored HTTP parser and triage the crashes.

## Solution

`fuzzer.cpp` drives `utils/http_parser.c`; crashes are replayed with `crash-me`.
Triage is the real skill: separate genuine parser bugs from harness artefacts, and judge exploitability from the faulting path.
`http_parser` is third-party and lives under `utils/`, so it is excluded from the project's lint.
See the [task](../../11-fuzzing-live/02-http-parser/README.md).
