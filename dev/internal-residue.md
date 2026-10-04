# Internal Residue

Files met while porting `sis-internal` and `sis-private` that do not belong in this public repository.
They go to the internal repository when `sis-internal` and `sis-private` are reduced to an `operating-systems-internal`-style repository (phase 4 of the restructuring plan).

| Source | What | Target in the internal repository |
| --- | --- | --- |
| `sis/templates/**/.config` (removed, in history) | Server addresses, ssh passwords, flag paths of the 2022 deployment | `deploy/<year>.env` |
| `sis-internal/lecture-tests/` | Lecture tests 1–5, LaTeX | `lectures/NN-<slug>/drills/questions/*.md` |
| `sis-private/intro/*/remote/setup` + `sol/extract` | Session 01 SSH challenge flags and `ctf` passwords, server addresses | `deploy/<year>.env` + per-challenge deploy notes |
| `sis-internal/05-defense/tasks/src/webshop` | Webshop DB password and flag | `deploy/<year>.env` |
| `sis-private/exploit-web-os/*/remote` | Session 04 web flags, DB passwords, addresses | `deploy/<year>.env` |
| `sis-internal/10-fuzzing/tasks/src/libFuzzer.a` | 7.4MB prebuilt libFuzzer; replaced by clang `-fsanitize=fuzzer` in the port | not needed (modernised) |
