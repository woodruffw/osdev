;	boot_sector3.asm
;	A 512-byte boot sector that prints "Hello, World!" using a defined function
;	DOES NOT WORK
;	Author: William Woodruff

print_special:
	pusha
	mov ah, 0x0e
	int 0x10
	popa
	ret

mov al, 'H'
call print_special
mov al, 'e'
call print_special
mov al, 'l'
call print_special
mov al, 'l'
call print_special
mov al, 'o'
call print_special
mov al, ','
call print_special
mov al, 'W'
call print_special
mov al, 'o'
call print_special
mov al, 'r'
call print_special
mov al, 'l'
call print_special
mov al, 'd'
call print_special
mov al, '!'
call print_special

jmp $

times 510-($-$$) db 0
dw 0xaa55
