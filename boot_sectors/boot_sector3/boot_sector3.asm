;	boot_sector3.asm
;	A 512-byte boot sector that prints "Hello, World!" using a defined function
;	Author: William Woodruff

[BITS 16]
[org 0x7c00]

mov al, 'H'
call print
mov al, 'e'
call print
mov al, 'l'
call print
mov al, 'l'
call print
mov al, 'o'
call print
mov al, ','
call print
mov al, 'W'
call print
mov al, 'o'
call print
mov al, 'r'
call print
mov al, 'l'
call print
mov al, 'd'
call print
mov al, '!'
call print

jmp $

print:
	mov ah, 0x0e
	int 0x10
	ret

times 510-($-$$) db 0
dw 0xaa55


