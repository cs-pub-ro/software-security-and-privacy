#include <stdio.h>

int main()
{
    int a = 1 ;
    a = a++;
    printf("a=%d\n", a); // compiled with gcc outputs 1
    return 0;
}
