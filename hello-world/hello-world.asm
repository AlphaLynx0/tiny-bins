BITS 32
ORG 0x08048000                 ; Standard Linux ELF load address

; ELF Header (52 bytes)
ehdr:
    db 0x7F, "ELF", 1, 1, 1, 0 ; Magic Number + 32-bit little-endian
    times 8 db 0               ; Padding
    dw 2                       ; Type: ET_EXEC
    dw 3                       ; Machine: x86
    dd 1                       ; Version
    dd _start                  ; Entry Point
    dd phdr - $$               ; Program Header Offset
    dd 0, 0                    ; No section headers
    dw 0x34, 0x20              ; ELF Header Size, Program Header Size
    dw 1                       ; Number of Program Headers
    dw 0, 0, 0                 ; No section headers

; Program Header (32 bytes)
phdr:                          ; Program Header
    dd 1                       ; Type: PT_LOAD
    dd 0                       ; Offset
    dd $$                      ; Virtual Address
    dd $$                      ; Physical Address
    dd filesize                ; File size
    dd filesize                ; Memory size
    dd 5                       ; Flags: R + X
    dd 0x1000                  ; Alignment

; Code Section
_start:
    mov al, 4                  ; sys_write
    inc ebx                    ; stdout=1
    mov ecx, msg               ; Pointer to message
    mov dl, msglen             ; Message length
    int 0x80                   

    xor eax, eax               
    inc eax                    ; sys_exit=1
    xor ebx, ebx               ; exit code 0
    int 0x80                   

msg:    db "Hello, world!", 10
msglen equ $ - msg
filesize equ $ - $$
