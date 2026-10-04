# Exercise: Swapper

**Tools:** GCC

## Goal

Decide whether two swap implementations are correct for every input, by reasoning about them rather than only running the tests.

## Background

`swapper.c` has two swaps: one with a temporary variable, one with the XOR trick.
Each has a stated contract: `a` and `b` are pointers to valid `long` variables.

## Your Task

1. Read both implementations and the contract.
1. Argue, on paper, that each is correct for all values, by tracking the memory through each assignment.
1. Then find an input that breaks one of them anyway, and add a test for it in `main`.

## Build & Run

```console
make
./swapper
```

## Check Your Work

One implementation has an implicit assumption its contract does not state.
Be ready to name that assumption, show the input that violates it, and say how the contract should change.
