# Instructor Notes: Session 11 --- Fuzzing

Local exercises. Build verification owed.

The Makefiles were modernised to clang's built-in libFuzzer (`-fsanitize=fuzzer`); the previous edition linked a prebuilt `libFuzzer.a`, which is no longer committed. Re-verify the builds on a machine with a recent clang.

The AFL and KLEE tutorials run in Docker (upstream afl-training and KLEE images); the previous edition also provided a dedicated fuzzing VM. Point students at those rather than committing the images.

Teaching arc: random input stalls on a guard (hard-to-fuzz), coverage feedback and seeds get past it, and real targets (http-parser) make triage the hard part; KLEE's symbolic execution is the contrast.
