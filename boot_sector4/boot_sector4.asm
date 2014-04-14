;	boot_sector4.asm
;	A 512-byte boot sector that uses more advanced functions for output
;	Author: William Woodruff

[BITS 16]
[org 0x7c00]

mov si, HELLO_WORLD_MSG
call print_string

jmp $ ; hang

print_string:
	pusha
	mov ah, 0x0e ; output
	.next:
		mov al, [si] ; load a byte from si
		inc si ; increment to the next byte
		cmp al, 0
		je .done ; if the current byte is 0 (null), return
		int 0x10
		jmp .next
	.done:
		popa
		ret

HELLO_WORLD_MSG:
	db 'Hello, World!', 0 ; null terminated string

times 510-($-$$) db 0 ; paddding
dw 0xaa55