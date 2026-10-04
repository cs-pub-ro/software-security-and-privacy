# fprotect

A demo of what `FORTIFY_SOURCE` (`-D_FORTIFY_SOURCE=2`) adds: the compiler replaces some unbounded library calls with checked variants that abort on overflow.
`buffers.c` shows what it catches and what it misses; build it with and without fortification and compare.
