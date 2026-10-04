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
        h = sha256(s.encode()).hexdigest()
        if h in hashes:
            print("{} -> {}".format(h, s), file=sys.stderr)
            hashes.remove(h)
    print('\n'.join(hashes))


if __name__ == "__main__":
    sys.exit(main())
