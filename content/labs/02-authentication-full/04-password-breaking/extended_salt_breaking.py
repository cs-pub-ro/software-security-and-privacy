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
        for h in list(hashes):
            if len(h) <= 64:
                continue
            prefix = bytes.fromhex(h[0:10])
            if sha256(prefix + t.encode()).hexdigest() == h[10:]:
                print("{} -> {}".format(h, t), file=sys.stderr)
                hashes.remove(h)
                continue
            suffix = bytes.fromhex(h[64:])
            if sha256(t.encode() + suffix).hexdigest() == h[0:64]:
                print("{} -> {}".format(h, t), file=sys.stderr)
                hashes.remove(h)
    print('\n'.join(hashes))


if __name__ == "__main__":
    sys.exit(main())
