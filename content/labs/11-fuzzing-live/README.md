# Session 11: Fuzzing

Finding bugs by throwing inputs at a program until it crashes: coverage-guided fuzzing with libFuzzer on a toy target and on a real HTTP parser, and the AFL and KLEE tutorials.

## Learning Objectives

After this session you should be able to:

* write a fuzz harness and run a coverage-guided fuzzer against it;
* fuzz a real library and triage the crashes it finds;
* explain what makes code hard to fuzz, and where symbolic execution (KLEE) helps.

## Prerequisites and Required Tools

* `clang` (with libFuzzer) and a C/C++ toolchain.
* Docker, for the AFL and KLEE tutorials.

Run `./scripts/check-prerequisites.sh 11` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`01-hard-to-fuzz`](01-hard-to-fuzz/) | exercise | Fuzz a target with a guard the fuzzer must get past |
| 2 | [`02-http-parser`](02-http-parser/) | exercise | Fuzz a real HTTP parser |

The AFL and KLEE tutorials run in Docker; follow the upstream afl-training and KLEE guides.
