# Webshop

## Goal

Find and exploit the SQL injection in the webshop, and use it to read `/flag` on the server.

## Solution

`index.php` builds a SQL query from unsanitised input, so the product listing is injectable.
From there, read the database and escalate to reading the UNIX `/flag` file (the web-root `flag` is a decoy).
`deploy/` serves the app; see its README for the PHP/MySQL caveat.
See the [task](../../05-defense-live/04-webshop/README.md).
