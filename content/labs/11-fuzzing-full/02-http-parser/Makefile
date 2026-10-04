# http_parser is third-party, vendored under utils/. Modernised to clang's
# built-in libFuzzer (-fsanitize=fuzzer). Build verification owed.
CFLAGS=-g -O2 -Iutils
CC=clang
CXX=clang++

all: libhttp_parser.so fuzzer crash-me

http_parser.o:
	$(CC) -fPIC $(CFLAGS) -c utils/http_parser.c -o http_parser.o

libhttp_parser.so: http_parser.o
	$(CC) $(CFLAGS) http_parser.o -shared -o libhttp_parser.so

fuzzer:
	$(CXX) $(CFLAGS) -fsanitize=fuzzer,address fuzzer.cpp utils/http_parser.c -o fuzzer

crash-me: libhttp_parser.so
	$(CC) $(CFLAGS) crash-me.c -L. -lhttp_parser -o crash-me

clean:
	rm -f *.o libhttp_parser.so fuzzer crash-me
