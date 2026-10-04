# Exercise: This Is Not Possible

**Tools:** GCC

## Goal

Find the input that makes `this_is_not_possible.c` reach a branch that looks unreachable.

## Background

The program parses its argument and takes an "impossible" path only for a particular value.
Floating-point parsing and comparison hide more edge cases than they appear to.

## Your Task

1. Read the program and identify the condition on the parsed value.
1. Find an argument that satisfies it.

## Check Your Work

Be ready to explain which property of floating-point (or of the parser) made the "impossible" possible.
