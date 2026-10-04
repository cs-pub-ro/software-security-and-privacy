#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <seccomp.h>

#define BUF_SIZE    256

static const char shellcode[] = "\x83\xec\x28\xbb\x03\x00\x00\x00\x89\xe1\xba\x14\x00\x00\x00\xb8\x03\x00\x00\x00\xcd\x80\xbb\x04\x00\x00\x00\x89\xe1\xba\x14\x00\x00\x00\xb8\x03\x00\x00\x00\xcd\x80\x83\xc4\x28\x83\xec\x04\xc7\x04\x24\x61\x6e\x61\x00\xbb\x03\x00\x00\x00\x89\xe1\xba\x03\x00\x00\x00\xb8\x04\x00\x00\x00\xcd\x80\xbb\x04\x00\x00\x00\x89\xe1\xba\x03\x00\x00\x00\xb8\x04\x00\x00\x00\xcd\x80\x83\xc4\x04";

int main(int argc, char *argv[])
{
	int rc = -1;
	scmp_filter_ctx ctx;
	int fd1, fd2;
	unsigned char buf[BUF_SIZE];
	ssize_t n;

	fd1 = open("../../jail/a.txt", O_RDWR);
	if (fd1 < 0) {
		perror("open(fd1)");
		exit(EXIT_FAILURE);
	}

	fd2 = open("../../b.txt", O_RDWR);
	if (fd2 < 0) {
		perror("open(fd2)");
		exit(EXIT_FAILURE);
	}

	ctx = seccomp_init(SCMP_ACT_ERRNO(42));
	if (ctx == NULL)
		goto out;

	rc = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(close), 0);
	if (rc < 0)
		goto out;

	rc = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(read), 3,
			SCMP_A0(SCMP_CMP_EQ, fd1),
			SCMP_A1(SCMP_CMP_EQ, (scmp_datum_t)buf),
			SCMP_A2(SCMP_CMP_LE, BUF_SIZE));
	if (rc < 0)
		goto out;

	rc = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(read), 3,
			SCMP_A0(SCMP_CMP_EQ, fd2),
			SCMP_A1(SCMP_CMP_EQ, (scmp_datum_t)buf),
			SCMP_A2(SCMP_CMP_LE, BUF_SIZE));
	if (rc < 0)
		goto out;

	rc = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(write), 1,
			SCMP_A0(SCMP_CMP_EQ, 1));
	if (rc < 0)
		goto out;

	rc = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(write), 1,
			SCMP_A0(SCMP_CMP_EQ, fd1));
	if (rc < 0)
		goto out;

	rc = seccomp_load(ctx);
	if (rc < 0)
		goto out;

	n = read(fd1, buf, BUF_SIZE);
	if (n < 0)
		printf("error read(fd1)\n");

	n = read(fd2, buf, BUF_SIZE);
	if (n < 0)
		printf("error read(fd2)\n");

	n = write(fd1, "ana", 3);
	if (n < 0)
		printf("error write(fd1)\n");

	n = write(fd2, "ana", 3);
	if (n < 0)
		printf("error write(fd2)\n");

	{
		void (*func_ptr)(void) = (void (*)(void)) shellcode;

		/* Call shellcode. */
		func_ptr();
	}

	printf("output\n");
	fprintf(stderr, "error\n");

	close(fd1);
	close(fd2);

	return 0;
out:
	seccomp_release(ctx);
	return -rc;
}
