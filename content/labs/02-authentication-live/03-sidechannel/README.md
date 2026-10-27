# Exercise: Side Channel

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/02-authentication-live/03-sidechannel
```

If you already cloned the repository for this lab, just `cd` into the directory above.

**Tools:** python3, g++

## Build & Run

```console
make
python3 break_sidechannel.py
```

## Goal

Guess a passphrase you cannot see, using only how long the program takes to reject it.

## Background

`sidechannel` authenticates a passphrase of the form `<article> <adjective> <noun>`, with the words drawn from the dictionaries in `dict/`.
It compares the input to the secret character by character and returns as soon as a character differs, and it prints its own execution time in microseconds.
The closer your guess is to the secret, the longer the comparison runs before it fails.

## Your Task

1. Read `sidechannel.cpp` and confirm where the early-return leaks timing.
1. Build the target with `make`, or use the shipped `sidechannel` binary.
1. Complete `break_sidechannel.py` to recover the passphrase one word at a time, choosing at each step the dictionary word that makes the program run longest.

## Check Your Work

The script should print the passphrase.
Be ready to explain why timing, and not the return value, is what gives the secret away, and what would remove the leak.
