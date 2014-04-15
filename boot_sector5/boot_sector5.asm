;	boot_sector5.asm
;	A 512-byte boot sector that attempts to read input from the user, echoing it
;	Author: William Woodruff

[BITS 16]
[org 0x7c00]

mov si, MSG1
call print_string

echo:
mov ah, 0x0 ; input
int 0x16
mov ah, 0x0e ; output
int 0x10
cmp al, '.' ; echo until period is pressed
jne echo

jmp $ ; hang

print_string:
	mov ah, 0x0e ; output
	.next:
		mov al, [si] ; load a byte from si
		inc si ; increment to the next byte
		cmp al, 0
		je .done ; if the current byte is 0 (null), return
		int 0x10
		jmp .next
	.done:
		ret

MSG1:
	db 'Enter something to echo:', 0x0a, 0x0d, 0x0 ; 0x0a/0x0d -> \n\r

times 510-($-$$) db 0 ; padding
dw 0xaa55