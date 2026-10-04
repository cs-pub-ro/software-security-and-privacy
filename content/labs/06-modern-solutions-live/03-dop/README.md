# Exercise: Data-Oriented Programming

**Tools:** GCC, Clang/LLVM

## Goal

Change a program's output without ever diverting its control flow, then watch a defence that only guards control flow fail to stop you.

## Background

`dop.c` has a buffer overflow in `f`, and `f` contains a while loop that acts as a tiny interpreter over data in memory.
By corrupting that data you steer the program's behaviour while every `ret` still goes where it should.
`payload.c` builds an example payload.

## Your Task

1. Read `dop.c` and find the overflow and the interpreter loop.
1. Study `payload.c`; fill in the missing addresses so `dop` prints `End of program: FAILAA!`.
1. Devise a payload that makes it print `End of program: SISPWN!`.
1. Rebuild `dop` with `-fsanitize=safe-stack` and run the exploit again. Explain what happens and why.

## Build & Run

```console
make
./dop < pl
```

## Check Your Work

Be ready to explain why this is called data-oriented programming, and why SafeStack (a control-flow defence) does or does not stop it.
