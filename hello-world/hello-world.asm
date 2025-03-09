BITS 32
ORG 0x08048000  ; Standard Linux ELF load address

ehdr:                          ; ELF Header (compressed)
    db 0x7F, "ELF", 1, 1, 1, 0  ; Magic Number + 32-bit little-endian
    times 8 db 0               ; Padding
    dw 2                       ; Type: ET_EXEC (executable)
    dw 3                       ; Machine: x86 (i386)
    dd 1                       ; Version
    dd _start                  ; Entry Point
    dd phdr - $$               ; Program Header Offset
    dd 0, 0                    ; No section headers
    dw 0x34, 0x20              ; ELF Header Size, Program Header Size
    dw 1                       ; Number of Program Headers
    dw 0, 0, 0                 ; No section headers

phdr:                          ; Program Header
    dd 1                       ; Type: PT_LOAD (loadable segment)
    dd 0                       ; Offset
    dd $$                      ; Virtual Address
    dd $$                      ; Physical Address
    dd filesize                ; File size
    dd filesize                ; Memory size
    dd 5                       ; Flags: R + X (Read & Execute)
    dd 0x1000                  ; Alignment (page size)

_start:
    ; sys_write(fd=1, buf=msg, count=len)
    push 4                     ; syscall: sys_write
    pop eax
    push 1                     ; stdout
    pop ebx
    lea ecx, [msg]             ; Pointer to message (fixed location)
    push msglen                ; Message length
    pop edx
    int 0x80                   ; Invoke syscall

    ; sys_exit(status=0)
    push 1                     ; syscall: sys_exit
    pop eax
    xor ebx, ebx               ; exit code 0
    int 0x80                   ; Invoke syscall

msg:                           ; Message stored **after** code
    db "Hello, world!", 10      ; Correct message placement
msglen equ $ - msg              ; Compute message length

filesize equ $ - $$             ; Compute total file size
