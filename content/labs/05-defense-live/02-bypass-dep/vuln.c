#include <stdio.h>
#include <stdlib.h>

static void reader(void)
{
	char buffer[64];

	printf("gimme message: ");
	fgets(buffer, 128, stdin);
	printf("hello, %s\n", buffer);
}

int main(void)
{
	puts("Greetings, your liege!");

	reader();

	return 0;
}
