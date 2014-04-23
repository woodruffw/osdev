[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

mov bp, 0x9000
mov sp, bp

mov si, REAL_MODE_MSG
call print_string_bios

call load_kernel

call switch_to_pm

jmp $ ; never reached

%include "../../include/print_string_bios.asm"
%include "../../include/disk_load.asm"
%include "../../include/protected_mode/gdt.asm"
%include "../../include/protected_mode/print_string_pm.asm"
%include "../../include/protected_mode/switch_to_pm.asm"

[bits 16]

load_kernel:
	mov si, KERN_LOAD_MSG
	call print_string_bios

	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

[bits 32]

BEGIN_PM:
	mov ebx, PROT_MODE_MSG
	call print_string_pm
	call KERNEL_OFFSET

	jmp $ ; hang


BOOT_DRIVE db 0
REAL_MODE_MSG db "Starting in real mode...", 0
PROT_MODE_MSG db "Entering protected mode...", 0
KERN_LOAD_MSG db "Loading kernel...", 0

times 510-($-$$) db 0
dw 0xaa55