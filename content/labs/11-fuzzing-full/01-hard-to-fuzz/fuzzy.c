#include "fuzzy.h"
#include <assert.h>
#include <string.h>
#include <stdio.h>

#define MAX_BUF (1 << 8)

unsigned int serial[] = { 0x31, 0x3e, 0x3d, 0x26, 0x31 };

unsigned short CheckByte(unsigned char *ptr, uint32_t len) {
	int i, j = 0;
	unsigned short hash = 0xABCD;

	for (i = 0; i < len; i++) {
		if (ptr[i] < 'A' || ptr[i] > 'Z')
			return 0;
		hash += ptr[i] ^ serial[j];

		j = (j == 4) ? 0 : j + 1;
	}

	return hash;
}

int checkcrc(uint32_t size, const uint8_t *data) {
	char buf[MAX_BUF];
	if (size < 20) return -1;
	if (CheckByte((unsigned char *)data, size) == 0xAD6D) {
		strcpy(buf, (char *)data);
	}
	return 0;
}
