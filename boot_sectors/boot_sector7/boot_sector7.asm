;	boot_sector7.asm
;	A 512-byte boot sector that enters protected mode and uses VGA to print a message
;	Author: William Woodruff

[org 0x7c00]
[bits 16]

mov bp, 0x9000 ; set the stack to a safe address
mov sp, bp

call enter_pm

jmp $ ; this statement is never reached, as enter_pm calls BEGIN_PM

%include "../../include/global_descriptor_table.asm"
%include "../../include/enter_protected_mode.asm"
%include "../../include/print_string_vga.asm"

[bits 32]

BEGIN_PM:
	mov ebx, MSG
	call print_string_vga

	jmp $ ; hang

MSG: db "Hello from 32-bit protected mode!", 0
MSGRM: db "Test", 0

times 510-($-$$) db 0
dw 0xaa55