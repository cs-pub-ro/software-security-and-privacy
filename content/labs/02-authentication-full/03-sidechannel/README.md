# Side Channel

## Goal

Recover the passphrase of `sidechannel` from its timing.

## Solution

The comparison in `sidechannel.cpp` returns on the first wrong character, so the running time grows with the length of the correct prefix.
The attack guesses one word at a time: for each candidate from the dictionary, measure the reported time over several runs, and keep the word that is consistently slowest; then move on to the next word with that prefix fixed.

`break_sidechannel.py` is the completed attack, and `sidechannel.py` is a Python reference of the target.
The fix is a constant-time comparison that always inspects the whole input.
