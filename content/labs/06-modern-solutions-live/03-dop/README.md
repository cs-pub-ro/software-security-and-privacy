# Exercise: Data-Oriented Programming

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/06-modern-solutions-live/03-dop
```

If you already cloned the repository for this lab, just `cd` into the directory above.

**Tools:** Clang/LLVM, binutils (`nm`)

## Goal

Change a program's output without ever diverting its control flow, then watch a defence that only guards control flow fail to stop you.

## Background

`dop.c` has a buffer overflow in `f`, and `f` contains a while loop that acts as a tiny interpreter over data in memory.
By corrupting that data you steer the program's behaviour while every `ret` still goes where it should.
`payload.c` builds an example payload.

## Your Task

1. Read `dop.c` and find the overflow and the interpreter loop.
1. Study `payload.c`; fill in the missing addresses so `dop` prints `End of program: FAILAA!`.
1. Devise a payload that makes it print `End of program: SSPPWN!`.
1. Rebuild `dop` with `-fsanitize=safe-stack` (`make safestack`) and run the exploit again. Explain what happens and why.

## Build & Run

`dop` is built non-PIE, so `vulbuf` and `zone1` are at fixed addresses you can read with `nm`:

```console
make
nm dop | grep -E ' vulbuf| zone1'   # fill these into payload.c, then rebuild it
make payload
./payload > pl && ./dop < pl
```

## Check Your Work

Be ready to explain why this is called data-oriented programming, and why SafeStack (a control-flow defence) does or does not stop it.
