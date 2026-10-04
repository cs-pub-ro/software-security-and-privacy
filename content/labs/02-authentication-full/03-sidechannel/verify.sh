#!/bin/sh
# The attack recovers the passphrase from the timing side channel and confirms
# it against the same target instance (exit 0 on "Access granted!").
exec python3 break_sidechannel.py
