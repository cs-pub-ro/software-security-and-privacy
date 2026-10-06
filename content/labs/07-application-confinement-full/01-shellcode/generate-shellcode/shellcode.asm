BITS 32

    jmp string          ; Use call trampoline trick.
back:
    pop ecx             ; Pop string address from stack.
    mov edx, 14         ; Message length is 14 bytes.
    mov ebx, 1          ; Print to standard output (fd = 1).
    mov eax, 4          ; __NR_write
    int 0x80

    jmp fname1
open1:
    pop ebx             ; file name
    xor ecx, ecx        ; O_RDONLY
    mov eax, 5          ; __NR_open
    int 0x80

    jmp fname2
open2:
    pop ebx             ; file name
    xor ecx, ecx        ; O_RDONLY
    mov eax, 5          ; __NR_open
    int 0x80

    xor ebx, ebx        ; exit value = 0
    mov eax, 1          ; __NR_exit
    int 0x80
string:
    call back
    db "Hello, World!", 10, 0
fname1:
    call open1
    db "a.txt", 0
fname2:
    call open2
    db "b.txt", 0
