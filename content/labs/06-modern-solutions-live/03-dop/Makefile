CC = clang
CFLAGS = -no-pie -fno-pie -g

.PHONY: all safestack clean

all: dop payload

dop: dop.c
	$(CC) $(CFLAGS) -o $@ $<

payload: payload.c
	$(CC) $(CFLAGS) -o $@ $<

# Rebuild dop with SafeStack for the last task (see the README).
safestack: dop.c
	$(CC) $(CFLAGS) -fsanitize=safe-stack -o dop $<

clean:
	rm -f dop payload pl *.o
