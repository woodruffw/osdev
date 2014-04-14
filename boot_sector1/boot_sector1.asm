;	boot_sector1.asm
;	A 512-byte boot sector that does nothing.
;	Author: William Woodruff

loop:
	jmp loop

times 510-($-$$) db 0

dw 0xaa55