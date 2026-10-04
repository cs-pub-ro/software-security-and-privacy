# Modernised to clang's built-in libFuzzer (-fsanitize=fuzzer); the previous
# edition linked a prebuilt libFuzzer.a. Build verification owed.
CFLAGS=-g -O2
CC=clang
CXX=clang++

all: libfuzzy.so fuzzy-fuzzer crash-me

fuzzy.o:
	$(CC) -fPIC $(CFLAGS) -c fuzzy.c

libfuzzy.so: fuzzy.o
	$(CC) $(CFLAGS) fuzzy.o -shared -o libfuzzy.so

fuzzy-fuzzer:
	$(CXX) $(CFLAGS) -fsanitize=fuzzer,address fuzzer.cpp fuzzy.c -o fuzzy-fuzzer

crash-me: libfuzzy.so
	$(CC) $(CFLAGS) crash-me.c -L. -lfuzzy -o crash-me

clean:
	rm -f *.o libfuzzy.so fuzzy-fuzzer crash-me
