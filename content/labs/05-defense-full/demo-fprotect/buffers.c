#include <stdio.h>

int f(void)
{
	return 10;
}

int g(void)
{
	int a;

	a = 100;

	return a;
}

void h(void)
{
	char buf[6];

	fgets(buf, 6, stdin);
}

void i(void)
{
	char buf[64];

	fgets(buf, 64, stdin);
}

int main(void)
{
	printf("%d, %d\n", f(), g());
	h();
	i();

	return 0;
}
