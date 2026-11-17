# Exercise: Monopoly

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/08-system-isolation-live/01-monopoly
```

If you already cloned the repository for this lab, just `cd` into the directory above.

**Tools:** a Linux machine with root

## Goal

Escape a chroot jail you entered as root, and read `/flag` on the real filesystem.

## Background

`chroot` changes a process's root directory, but it does not drop privilege.
A root process inside a chroot can change its root again and walk back out, because the kernel does not stop it.

**Do not remove the `jail` folder by hand.**
Use only the provided scripts: `go_to_jail` enters the jail, `destroy_jail` cleans it up.

## Your Task

1. Run `sudo ./go_to_jail` to enter the jail.
1. Escape the chroot and read the real `/flag`.
1. Run `sudo ./destroy_jail` to clean up.

## Check Your Work

You should read a `/flag` that is not visible from inside the jail.
Be ready to explain why being root is what makes the escape possible, and what actually confines a root process.
