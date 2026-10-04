# Data-Oriented Programming

## Goal

Steer `dop` by corrupting data, not control flow, and compare against SafeStack.

## Solution

The overflow in `f` reaches the data its interpreter loop reads, so a crafted payload drives the loop to a chosen result without diverting any branch.
`solve/payload.c` and `solve/sol_payload.py` build the payloads for the `FAILAA!` and `SISPWN!` outputs.
SafeStack moves the vulnerable buffer off the unsafe stack; discuss whether it stops this, given the attack never changes a return address.

## Build

`build/` has `dop.c`, `payload.c` and the Makefile.
