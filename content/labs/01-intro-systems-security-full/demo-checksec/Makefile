.PHONY: all clean

all: all_hardening no_hardening

all_hardening: hello.c
	gcc -fstack-protector-all -pie -Wl,-z,relro,-z,now -o $@ $^

no_hardening: hello.c
	gcc -fno-stack-protector -no-pie -zexecstack -o $@ $^

test: all_hardening no_hardening
	checksec $^

clean:
	-rm -f all_hardening
	-rm -f no_hardening
