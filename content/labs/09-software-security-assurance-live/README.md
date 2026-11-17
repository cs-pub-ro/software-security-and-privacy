# Session 09: Software Security Assurance

Finding bugs by reading and analysing code, before it ever runs: undefined behaviour the compiler is free to do anything with, and the classic flaws a static analyser flags.

## Getting the Files

Clone the repository to get the challenge source files:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/09-software-security-assurance-live
```

Challenges that need local files have a Setup section pointing to the exact subdirectory.

## Prerequisites and Required Tools

* `gcc` (with `-Wall -Wextra`).
* `cppcheck`, `flawfinder`, `clang-tidy`.

Run `./scripts/check-prerequisites.sh 09` to check.

## Learning Objectives

After this session you should be able to:

* spot undefined behaviour in C and explain why its output cannot be relied on;
* reason about edge cases that a quick reading misses;
* run a static analyser and read its findings critically.

## Tasks

| Order | Task | Objective |
| --- | --- | --- |
| 1 | [`01-aplusplus`](01-aplusplus/) | Undefined behaviour in a single statement |
| 2 | [`02-weird`](02-weird/) | Sequence points and evaluation order |
| 3 | [`03-this-is-not-possible`](03-this-is-not-possible/) | An edge case that looks impossible |
| 4 | [`04-hidden-bugs`](04-hidden-bugs/) | Eight bugs, found with analysis |
