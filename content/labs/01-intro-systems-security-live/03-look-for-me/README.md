# Exercise: Look for Me

**Tools:** SSH, tar, find

## Goal

Read a flag you cannot open directly, from a copy of it you can.

## Background

The flag is in a file your account cannot read.
But something else on the system can be read, and it happens to contain a copy of the flag.

## Your Task

1. Connect over SSH to the address listed on the CTF platform.
1. Confirm you cannot read the flag file directly.
1. Find a readable artifact on the system that contains a copy of it, and extract the flag from there.

## Check Your Work

You should recover a string of the form `SSP{...}` without ever reading the flag file itself.
Be ready to explain where the copy came from.
