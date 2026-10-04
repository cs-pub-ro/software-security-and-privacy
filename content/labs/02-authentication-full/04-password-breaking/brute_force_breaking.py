#!/usr/bin/python

import sys
from hashlib import sha256
import itertools
import string


hashes = []


def brute_force_module():
    global hashes
    current = list(hashes)
    for s in itertools.product(string.printable, repeat=4):
        s = ''.join(s)
        hash_to_match = sha256(s).hexdigest()
        if hash_to_match in current:
            print >> sys.stderr, "{} -> {}".format(hash_to_match, s)
            hashes.remove(hash_to_match)


def main():
    global hashes
    # Read hashes from standard input.
    hashes = [line.strip() for line in sys.stdin]
    brute_force_module()
    print '\n'.join(h for h in hashes)


if __name__ == "__main__":
    sys.exit(main())
