#!/usr/bin/python3

import sys
from hashlib import sha256


def main():
    hashes = [line.strip() for line in sys.stdin]
    h = sha256(b"dummy").hexdigest()
    if h in hashes:
        print("{} -> {}".format(h, "dummy"), file=sys.stderr)
        hashes.remove(h)
    print('\n'.join(hashes))


if __name__ == "__main__":
    sys.exit(main())
