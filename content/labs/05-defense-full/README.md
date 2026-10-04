# Session 05: Defense and Mitigation

The reference half of the [defense lab](../05-defense-live/README.md).

Three binary challenges (`01-use-shellcode`, `02-bypass-dep`, `03-bypass-aslr`) have the build/publish/deploy/solve pipeline and the reference exploits; `04-webshop` is a web challenge served over HTTP.

## Tasks

| Order | Task | Technique |
| --- | --- | --- |
| 1 | [`demo-fprotect`](demo-fprotect/) | FORTIFY_SOURCE |
| 2 | [`01-use-shellcode`](01-use-shellcode/) | Code injection on an executable stack |
| 3 | [`02-bypass-dep`](02-bypass-dep/) | Code reuse against NX |
| 4 | [`03-bypass-aslr`](03-bypass-aslr/) | Leak or brute force against ASLR |
| 5 | [`04-webshop`](04-webshop/) | SQL injection |
