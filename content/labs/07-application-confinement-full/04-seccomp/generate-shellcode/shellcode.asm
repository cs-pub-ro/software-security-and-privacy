BITS 32

    sub esp, 40
read1:
    mov ebx, 3      ; fd1
    mov ecx, esp    ; buffer start
    mov edx, 20     ; length
    mov eax, 3      ; __NR_read
    int 0x80

read2:
    mov ebx, 4      ; fd2
    mov ecx, esp    ; buffer start
    mov edx, 20     ; length
    mov eax, 3      ; __NR_read
    int 0x80

    ; restore stack
    add esp, 40

    sub esp, 4
    mov dword [esp], 0x616e61
write1:
    mov ebx, 3      ; fd1
    mov ecx, esp    ; message
    mov edx, 3      ; length
    mov eax, 4      ; __NR_write
    int 0x80

write2:
    mov ebx, 4      ; fd1
    mov ecx, esp    ; message
    mov edx, 3      ; length
    mov eax, 4      ; __NR_write
    int 0x80

    ; restore stack
    add esp, 4
    ret
