# Exercise: Reverse Kitten

**Tools:** SSH

## Goal

Read a flag your account has no permission to read, by acting as something that does.

## Background

The flag file is not readable by you.
The restriction is on *who* reads it, not on the file itself, so the way through is to have something with more privilege do the reading for you.

## Your Task

1. Connect over SSH to the address listed on the CTF platform.
1. Look at what your account is allowed to run with extra privilege.
1. Use that to read the flag.

## Check Your Work

You should recover a string of the form `SSP{...}`.
Be ready to explain what privilege you borrowed and how.
