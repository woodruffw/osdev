;	boot_sector6.asm
;	A 512-byte boot sector that demonstrates reading data from a disk
;	Author: William Woodruff

[BITS 16]
[org 0x7c00]

mov [BOOT_DRIVE], dl

mov bp, 0x8000 ; set the stack pointer somewhere safe
mov sp, bp

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call load_disk

mov al, [0x9000]
mov ah, 0x0e
int 0x10

jmp $ ; hang

%include "../include/print_string.asm"

; args: DH - sectors, ES:BX - address range, DL - drive
load_disk:
	pusha
	push dx
	mov ah, 0x02 
	mov al, dh
	mov ch, 0x00 ; cylinder 0
	mov dh, 0x00 ; head 0
	mov cl, 0x02 ; sector 2 (sector 1 is boot)
	int 0x13 ; interrupt 0x13 w/ ah 0x02 -> read from disk

	jc read_error

	pop dx
	cmp dh, al
	jne read_error
	popa
	ret

read_error:
	mov si, DISK_ERROR_MSG
	call print_string
	jmp $ ; hang

BOOT_DRIVE: db 0
DISK_ERROR_MSG: db "Read error.", 0

times 510-($-$$) db 0 ; padding
dw 0xaa55

times 512 dw 0x4141 ; pad the next sector with 'A's