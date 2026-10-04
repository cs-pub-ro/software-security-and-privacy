# Password Breaking

## Goal

Crack the SHA-256 hashes in `passwords.hash`.

## Solution

The completed scripts here crack the hashes in stages:

* `dictionary_breaking.py` --- hash each dictionary word and match.
* `hybrid_breaking.py` --- apply the leet substitutions to each word before hashing.
* `extended_breaking.py` --- also try trailing punctuation on the word and its hybrid form.
* `salt_breaking.py` / `extended_salt_breaking.py` --- for the longer entries that store a salt, prefixed or suffixed, split the salt off and hash in the right order.

`run-all` runs them together.
The lesson: unsalted hashes fall to precomputation and rules; a per-password salt forces the work to be redone for every hash.
