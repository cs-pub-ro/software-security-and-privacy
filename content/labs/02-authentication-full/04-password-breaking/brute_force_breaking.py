#!/usr/bin/python3

import itertools
import os
import sys
from hashlib import sha256

# Length and alphabet of the brute-force search; small by default because the
# cost is alphabet**length. Override to widen (e.g. BRUTE_LEN=5).
ALPHABET = os.environ.get("BRUTE_ALPHABET",
                          "abcdefghijklmnopqrstuvwxyz0123456789")
LENGTH = int(os.environ.get("BRUTE_LEN", "4"))


def main():
    hashes = [line.strip() for line in sys.stdin]
    for tup in itertools.product(ALPHABET, repeat=LENGTH):
        if not hashes:
            break
        s = ''.join(tup)
        h = sha256(s.encode()).hexdigest()
        if h in hashes:
            print("{} -> {}".format(h, s), file=sys.stderr)
            hashes.remove(h)
    print('\n'.join(hashes))


if __name__ == "__main__":
    sys.exit(main())
