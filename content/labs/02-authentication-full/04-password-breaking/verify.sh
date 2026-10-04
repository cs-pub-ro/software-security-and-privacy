#!/bin/sh
# Verify the reference crackers against the challenge's hashes.
#
# The dictionary-based stages (dictionary, hybrid, extended, salt,
# extended_salt) recover the structured passwords; they are what this checks.
# The brute-force stage is alphabet**length and only reaches very short
# passwords, so it is left out of the automated check.
set -eu

LIVE=../../02-authentication-live/04-password-breaking
export WORDLIST="$LIVE/dict/words"

total=$(grep -c . "$LIVE/passwords.hash")
remaining=$(grep . "$LIVE/passwords.hash" \
    | python3 dummy_breaking.py \
    | python3 dictionary_breaking.py \
    | python3 hybrid_breaking.py \
    | python3 extended_breaking.py \
    | python3 salt_breaking.py \
    | python3 extended_salt_breaking.py 2>/dev/null \
    | grep -c . || true)
cracked=$((total - remaining))
echo "cracked $cracked / $total via the dictionary-based stages"
echo "(the remaining $remaining need brute force, left out of this check)"

# The 50 structured passwords must all fall to the dictionary-based stages.
[ "$cracked" -ge 50 ]
