#!/usr/bin/python3

import os
import sys
from hashlib import sha256

# The wordlist defaults to the challenge's, but can be pointed elsewhere.
WORDLIST = os.environ.get("WORDLIST", "dict/words")


def words():
    with open(WORDLIST) as f:
        return [line.strip() for line in f]


def main():
    hashes = [line.strip() for line in sys.stdin]
    for s in words():
        for h in list(hashes):
            if len(h) <= 64:
                continue
            # salt prefixed: first 5 bytes (10 hex) are the salt
            prefix = bytes.fromhex(h[0:10])
            if sha256(prefix + s.encode()).hexdigest() == h[10:]:
                print("{} -> {}".format(h, s), file=sys.stderr)
                hashes.remove(h)
                continue
            # salt suffixed: trailing bytes after the 64-hex digest
            suffix = bytes.fromhex(h[64:])
            if sha256(s.encode() + suffix).hexdigest() == h[0:64]:
                print("{} -> {}".format(h, s), file=sys.stderr)
                hashes.remove(h)
    print('\n'.join(hashes))


if __name__ == "__main__":
    sys.exit(main())
