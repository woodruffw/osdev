;	print_string
;	prints a null-terminated string pointed to by the si register
;	IMPORTANT: string MUST be null-terminated
print_string:
	mov ah, 0x0e
	.next:
		mov al, [si]
		
		je .done
		int 0x10
		jmp .next
	.done:
		ret