# Exercise: Webshop

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/05-defense-live/04-webshop
```

If you already cloned the repository for this lab, just `cd` into the directory above.

**Tools:** a web browser, curl

## Goal

Find and exploit the SQL injection in the webshop to read the flag the server is hiding.

## Background

The webshop (`index.php`) builds a SQL query directly from `$_GET['id']` without sanitising it.
The page serves a decoy flag in the web root; the real flag is the UNIX file `/flag` on the server, reachable only through the database.

## Your Task

1. Browse to the webshop at the address listed on the CTF platform.
1. Read `index.php` (in the archive) and find where user input reaches a query unsanitised.
1. Use a `UNION SELECT` injection to read the database contents.
1. Escalate to reading `/flag` from the server's filesystem via `LOAD_FILE('/flag')`.

## Check Your Work

The flag starts with `SSP{`.
Be ready to show the injected query and explain how a parameterised statement would have stopped it.
