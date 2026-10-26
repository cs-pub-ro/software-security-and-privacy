# Solve

The webshop has a SQL injection in the product listing: `index.php` concatenates
`$_GET['id']` straight into `select * from products where id=...`.

`exploit.py` is the reference solution. The `products` table has four columns,
so a `UNION SELECT 1, LOAD_FILE('/flag'), 3, 4` appends a row whose "name" cell
is echoed back; `LOAD_FILE` reads the UNIX `/flag` on the server, which
is the flag the challenge hides (the web-root `flag` is a decoy). `/flag` is
passed as a hex literal to avoid quoting.

```console
docker build -t 04-webshop-solver .
docker run --rm --network host -v "$(pwd):/solve" -w /solve \
    04-webshop-solver python3 /solve/exploit.py --host 127.0.0.1 --port 10018
```

`ssp-deploy.py check-solution` runs the same exploit against a deployment.
