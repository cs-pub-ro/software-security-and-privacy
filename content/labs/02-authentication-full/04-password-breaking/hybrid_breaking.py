#!/usr/bin/python3

import os
import sys
from hashlib import sha256

# The wordlist defaults to the challenge's, but can be pointed elsewhere.
WORDLIST = os.environ.get("WORDLIST", "dict/words")


def words():
    with open(WORDLIST) as f:
        return [line.strip() for line in f]


def leet(s):
    return s.replace('a', '@').replace('e', '3').replace('i', '!') \
            .replace('o', '0').replace('s', '$')


def main():
    hashes = [line.strip() for line in sys.stdin]
    for s in words():
        t = leet(s)
        h = sha256(t.encode()).hexdigest()
        if h in hashes:
            print("{} -> {}".format(h, t), file=sys.stderr)
            hashes.remove(h)
    print('\n'.join(hashes))


if __name__ == "__main__":
    sys.exit(main())
