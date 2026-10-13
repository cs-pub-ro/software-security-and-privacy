# Exercise: ROP Chain

**Tools:** GDB, ROPgadget, pwntools

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/06-modern-solutions-live/02-rop-chain
```

If you already cloned the repository for this lab, just `cd` into the directory above.

## Build & Run

```console
make
```

The deployed challenge is on the CTF platform, in this session's category.

## Goal

Call `mega_checker()` with two arguments set up entirely through gadgets.

## Background

`mega_checker()` is reached only after `checker()`, and both the `ihahaha!` and `Uberihahaha!` messages must print.
To call it correctly you have to initialise `RDI` (first argument) and `RSI` (second argument) before returning into it.

## Your Task

1. Build `vuln` with `make`.
1. Find gadgets to set `RDI` and `RSI`.
1. Assemble the chain in `exploit.py` so both messages print.

## Check Your Work

Both messages should print.
Be ready to explain the order of the chain and why each register has to be set before the call.
