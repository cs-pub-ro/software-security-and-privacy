# Exercise: Weird

**Tools:** GCC

## Goal

Work out why `b = a++ + ++a + a++;` has no single correct value.

## Your Task

1. Read `weird.c` and try to predict `a` and `b`.
1. Compile with `-Wall -Wextra` and read the warnings.
1. Run it under two compilers or two optimisation levels and compare.

## Check Your Work

Be ready to explain sequence points: why modifying `a` several times between them is undefined, not merely implementation-defined.
