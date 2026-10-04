.PHONY: all clean

all: vuln_no_ssp vuln_ssp

vuln_no_ssp: vuln.c
	$(CC) -fno-stack-protector -o $@ $^

vuln_ssp: vuln.c
	$(CC) -fstack-protector -o $@ $^

clean:
	-rm -f vuln_ssl vuln_no_ssp
