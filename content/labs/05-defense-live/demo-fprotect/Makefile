# Build buffers.c twice -- without and with _FORTIFY_SOURCE -- to compare what
# fortification changes. FORTIFY_SOURCE only takes effect with optimisation, so
# both are built at -O2; the difference is the fortify level.
CFLAGS = -Wall -g -O2

.PHONY: all clean

all: buffers buffers-fortified

buffers: buffers.c
	$(CC) $(CFLAGS) -D_FORTIFY_SOURCE=0 -o $@ $^

buffers-fortified: buffers.c
	$(CC) $(CFLAGS) -D_FORTIFY_SOURCE=2 -o $@ $^

clean:
	-rm -f buffers buffers-fortified *.o
