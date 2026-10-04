# Exercise: Hidden Bugs

**Tools:** GCC, cppcheck, flawfinder, clang-tidy

## Goal

Find the eight bugs in `hidden-bugs.c`.

## Background

The file is a small program with eight planted flaws, from a classic Black Hat exercise.
Some a compiler warns about, some a static analyser catches, and some only a careful reading finds.

## Your Task

1. Read the code and list every bug you can find by eye.
1. Run `gcc -Wall -Wextra`, `cppcheck`, `flawfinder` and `clang-tidy` on it.
1. Reconcile the tools' findings with your list: which bugs did each catch, and which did none?

## Check Your Work

Aim for all eight.
Be ready to say which bugs no tool found, and why a human reading is still needed.
