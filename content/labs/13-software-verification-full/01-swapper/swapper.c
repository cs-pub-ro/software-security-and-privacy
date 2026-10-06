#include <stdio.h>

/*
 * Two swap implementations: using a temporary variable, and using a XOR trick.
 *
 * Contract: the function arguments, a and b, must be pointers to valid
 * memory representing variables of type long.
 */

static void swap_temp(long *a, long *b)
{
  long temp = *a;
  *a = *b;
  *b = temp;
}

static void swap_xor(long *a, long *b)
{
  *a = *a ^ *b;
  *b = *a ^ *b;
  *a = *a ^ *b;
}

/*
 * Main function: a set of tests for our swap implementations.
 *
 * TODO: Write more tests.
 *
 * CHALLENGE: Find tests that break at least one of the implementations.
 */
int main(void)
{
  long a = 0xdeadbeefcafe, b = 0xbabecafec0de;

  printf("Before swap: a = %lx, b = %lx\n", a, b);
  swap_temp(&a, &b);
  printf("After swap_temp: a = %lx, b = %lx\n", a, b);
  swap_xor(&a, &b);
  printf("After swap_xor: a = %lx, b = %lx\n", a, b);

  /* The equational proof assumes a and b do not alias. When they do, the XOR
   * swap destroys the value: *a = *a ^ *a = 0. This is the input that breaks it. */
  long c = 0x1234;
  printf("Aliasing: c = %lx\n", c);
  swap_xor(&c, &c);
  printf("After swap_xor(&c, &c): c = %lx\n", c);

  return 0;
}
