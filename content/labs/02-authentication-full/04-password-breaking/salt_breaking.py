#!/usr/bin/python

import sys
from hashlib import sha256


hashes = []


def salt_module():
    global hashes
    current = list(hashes)
    for s in [line.strip() for line in open("../../public/password-breaking/dict/words")]:
        s = ''.join(s)
        for h in current:
            if len(h) > 64:
                prefix = h[0:10].decode("hex")
                rest = h[10:]
                hash_to_match = sha256(prefix+s).hexdigest()
                if hash_to_match == rest:
                    print >> sys.stderr, "{} -> {}".format(hash_to_match, s)
                    hashes.remove(h)
                suffix = h[64:].decode("hex")
                rest = h[0:64]
                hash_to_match = sha256(s+suffix).hexdigest()
                if hash_to_match == rest:
                    print >> sys.stderr, "{} -> {}".format(hash_to_match, s)
                    hashes.remove(h)


def main():
    global hashes
    # Read hashes from standard input.
    hashes = [line.strip() for line in sys.stdin]
    salt_module()
    print '\n'.join(h for h in hashes)


if __name__ == "__main__":
    sys.exit(main())
