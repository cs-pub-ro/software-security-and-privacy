# Exercise: Webshop

**Tools:** a web browser, curl

## Goal

Find the SQL injection in the webshop and use it to read the flag the server is hiding.

## Background

The webshop (`index.php`, `login.php`) builds SQL queries from your input.
The page shows a decoy; the real flag is in a UNIX file `/flag` on the server, which you have to reach through the injection.

## Your Task

1. Browse the deployed webshop (its address is on the CTF platform).
1. Read the PHP source here and find where input reaches a SQL query unsanitised.
1. Exploit the injection to read the database, then the `/flag` file.

## Check Your Work

The flag is of the form `SSP{...}`.
Be ready to show the injected input and explain how a prepared statement would have stopped it.
