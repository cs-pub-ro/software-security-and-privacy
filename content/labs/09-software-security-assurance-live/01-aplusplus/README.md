# Exercise: a++

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/09-software-security-assurance-live/01-aplusplus
```

If you already cloned the repository for this lab, just `cd` into the directory above.

**Tools:** GCC

## Goal

Explain what `a = a++;` does, and why no explanation is the right one.

## Your Task

1. Read `aplusplus.c` and predict the output.
1. Compile it with `gcc -Wall -Wextra` and note the warning.
1. Run it, then recompile at `-O0` and `-O2` and run again.

## Check Your Work

The output may differ between optimisation levels or compilers.
Be ready to explain what "undefined behaviour" means here and why the warning, not the output, is the thing to trust.
