# Session 13: Software Verification

Reasoning about whether a program is correct, rather than testing it: proving a property holds for every input, and finding the hidden assumption that makes a "clever" trick wrong.

## Learning Objectives

After this session you should be able to:

* argue a small function's correctness by equational reasoning, not by running it;
* find the input that breaks an implementation whose contract is too weak;
* explain why pointer aliasing makes verification hard.

## Prerequisites and Required Tools

* `gcc`.

Run `./scripts/check-prerequisites.sh 13` to check.

## Tasks

| Order | Task | Objective |
| --- | --- | --- |
| 1 | [`01-swapper`](01-swapper/) | Prove, then break, a swap function |
