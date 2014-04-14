;	boot_sector2.asm
;	A 512-byte boot sector that prints "Hello, World!"
;	Author: William Woodruff

mov ah, 0x0e	; int 0x10 with 0x0e invokes scrolling teletype

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ','
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55