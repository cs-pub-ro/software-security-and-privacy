# Exercise: AppArmor

**Tools:** AppArmor

## Goal

Use an AppArmor profile to let the program from task 1 open `a.txt`, but not `b.txt`.

## Background

AppArmor confines a program to a set of files and capabilities declared in a profile under `/etc/apparmor.d/`.
With a profile loaded, the first `open` succeeds and the second fails.

## Your Task

1. Make sure AppArmor is installed and enabled (configure GRUB via `/etc/default/grub`).
1. Write a profile for the `exec` program that allows `a.txt` and denies `b.txt`, using full paths; start from an existing profile such as `bin.ping`.
1. Load the profile and run the program; use `ps -efZ` to confirm it is confined.

## Check Your Work

Only the allowed file should open.
Be ready to explain what AppArmor keys on (the path of the executable) and its limits.
