;	print_string_vga
;	prints a null-terminated string of characters pointed to by ebx
;	operates in protected mode - uses VGA mode

[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_vga:
	pusha
	mov edx, VIDEO_MEMORY

	.next:
		mov al, [ebx]
		mov ah, WHITE_ON_BLACK

		cmp al, 0
		je .done

		mov [edx], ax
		add ebx, 1
		add edx, 2

		jmp .next

	.done:
		popa
		ret