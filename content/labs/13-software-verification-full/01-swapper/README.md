# Swapper

## Goal

Prove both swaps correct, then find the input that breaks the XOR version.

## Solution

The reasoning below is reproduced from the reference solution.

```text

The amount of code we have to write is very small, so we'll use virtual pen and paper to explain this. ;)

The C implementation of swap_xor is:

  static void swap_xor(long *a, long *b)
  {
    *a = *a ^ *b;
    *b = *a ^ *b;
    *a = *a ^ *b;
  }

To verify that this works, let's first write down the truth table of XOR:

+---+---+-------+
| a | b | a ^ b |
+---+---+-------+
| 0 | 0 |   0   |
| 0 | 1 |   1   |
| 1 | 0 |   1   |
| 1 | 1 |   0   |
+---+---+-------+

... which we can extend to (a ^ b) ^ b (using the definition of "^" above):

+---+---+-------------+
| a | b | (a ^ b) ^ b |
+---+---+-------------+
| 0 | 0 |      0      |
| 0 | 1 |      0      |
| 1 | 0 |      1      |
| 1 | 1 |      1      |
+---+---+-------------+

Thus we have shown that (a ^ b) ^ b == a, for all values of a and b. Similarly, we can show that (a ^ b) ^ a == b.

Then, using equational reasoning, we can show that swap_xor is correct. To do this, we keep track of the modifications of a and b by labeling their changes in time; e.g. at the beginning a0 is given as a parameter, then after the first assignment it changes to a1, etc. We also use "->" to track what the pointers in each memory location point to. Thus:

(0) a0 = a; b0 = b.                | *a -> a; *b -> b
(1) a1 = a0 ^ b0 = a ^ b           | *a -> a ^ b; *b -> b
(2) b1 = a1 ^ b0 = (a ^ b) ^ b = a | *a -> a ^ b; *b -> a
(3) a2 = a1 ^ b1 = (a ^ b) ^ a = b | *a -> b; *b -> a

Thus we know that at the end, the value of b will be equal to the previous value of a, and vice-versa.

However, the XOR swap trick rests on an implicit assumption, i.e. that a and b live at *distinct* memory locations. What does e.g.

  swap_xor(&a, &a);
  printf("After swap_xor(&a, &a): a = %lx", a);

return?

We can find out without executing any code, using the same handy equation reasoning tool:

(0) a0 = a; b0 = a           | *a -> a; *b is the same as *a
(1) a1 = a0 ^ b0 = a ^ a = 0 | *a -> 0
(2) b1 = a1 ^ b0 = 0 ^ 0 = 0 | *a -> 0
(3) a2 = a1 ^ b1 = 0 ^ 0 = 0 | *a -> 0

Thus if the programmer intends to use swap_xor, they should explicitly modify the contract to disable pointer aliasing. Unfortunately pointer aliasing is a very hard problem: in general, there is no way to demonstrate that two pointers address distinct memory regions. For this reason, some programs (e.g. in safety-critical systems) never use dynamic allocation and make only limited use of pointers, and more recently, a new class of logics named separation logic are employed to reason about heaps.
```
