# gcc:11 (Debian bullseye) still ships __libc_csu_init in its C runtime, so the
# linked binary carries the `pop rdi; ret` and `pop rsi; pop r15; ret` gadgets
# this ROP exercise teaches; newer toolchains dropped it.
FROM gcc:11

WORKDIR /build
