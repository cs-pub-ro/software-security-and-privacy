# Solve

The webshop has a SQL injection in the product listing (`index.php`).

The injection yields database contents, and, combined with the app's file access, is the path to reading the UNIX `/flag` file that the challenge really wants (the served `flag` string is a decoy pointing there).
No automated reference exploit is carried; the manual steps are in the task write-up.
