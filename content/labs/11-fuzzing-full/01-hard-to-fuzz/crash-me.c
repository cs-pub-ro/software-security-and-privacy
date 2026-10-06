#include "fuzzy.h"
#include <stdio.h>
#include <assert.h>
#include <unistd.h>

#define MAX_BUF_LEN (1<<20)

int main() {
	char buf[MAX_BUF_LEN];
	size_t len;

	printf("Send buffer size\n");
	scanf("%zu", &len);

	assert(len <= MAX_BUF_LEN);
	printf("Provide: %zu bytes\n", len);

	size_t read_bytes = 0;
	while (read_bytes < len) {
		int ret = read(0, buf + read_bytes, len - read_bytes);
		if (!ret) break;
		assert(ret != -1);
		read_bytes += ret;
	}
	checkcrc(len, (uint8_t *)buf);
}
