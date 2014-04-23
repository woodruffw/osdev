;	print_string_bios
;	prints a null-terminated string pointed to by the si register
;	IMPORTANT: string MUST be null-terminated
[bits 32]
print_string_bios:
	mov ah, 0x0e
	.next:
		mov al, [si]
		
		je .done
		int 0x10
		jmp .next
	.done:
		ret