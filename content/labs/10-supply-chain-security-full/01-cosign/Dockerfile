FROM gcc:13.2 AS build

COPY hello.c src/hello.c

WORKDIR src

RUN gcc -Wall -o hello hello.c

FROM scratch

# Node binary
COPY --from=build /src/hello /hello

# System libraries
COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

CMD ["./hello"]
