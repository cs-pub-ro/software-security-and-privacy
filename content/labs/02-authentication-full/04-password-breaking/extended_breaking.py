#!/usr/bin/python

import sys
from hashlib import sha256


hashes = []


def hybrid_module():
    global hashes
    current = list(hashes)
    for s in [line.strip() for line in open("../../public/password-breaking/dict/words")]:
        s1 = ''.join(s)
        s2 = s1.replace('a', '@').replace('e', '3').replace('i', '!').replace('o', '0').replace('s', '$')
        for suffix in ["!", ".", "...", "?"]:
            for t in [s1+suffix, s2+suffix]:
                hash_to_match = sha256(t).hexdigest()
                if hash_to_match in current:
                    print >> sys.stderr, "{} -> {}".format(hash_to_match, t)
                    hashes.remove(hash_to_match)


def main():
    global hashes
    # Read hashes from standard input.
    hashes = [line.strip() for line in sys.stdin]
    hybrid_module()
    print '\n'.join(h for h in hashes)


if __name__ == "__main__":
    sys.exit(main())
