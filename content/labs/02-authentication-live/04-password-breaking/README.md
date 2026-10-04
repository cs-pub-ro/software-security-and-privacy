# Exercise: Password Breaking

**Tools:** python3

## Goal

Recover plaintext passwords from a file of SHA-256 hashes, with and without salt.

## Background

`passwords.hash` holds SHA-256 hashes of varying strength.
The scripts in `cracking-scripts/` are skeletons: `dummy_breaking.py` is the template, and `run-all` runs them together.
The dictionaries are in `dict/`.

## Your Task

1. Fill `dictionary_breaking.py` for a plain dictionary attack using `dict/words`.
1. Fill `hybrid_breaking.py` to re-run it with common letter-to-symbol substitutions (`a->@`, `e->3`, `i->!`, `o->0`, `s->$`).
1. Fill `extended_breaking.py` to also try trailing punctuation (`.`, `...`, `!`, `?`).
1. Fill `salt_breaking.py` and `extended_salt_breaking.py` for the salted entries (salt stored prefixed or suffixed).

## Build & Run

```console
python3 cracking-scripts/dictionary_breaking.py
./cracking-scripts/run-all
```

## Check Your Work

Each stage should crack a further batch of hashes.
Be ready to say why salting defeats a plain dictionary attack and the substitutions do not.
