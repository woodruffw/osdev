disk_load:
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
	ret

read_error:
	mov si, DISK_ERROR_MSG
	call print_string_bios
	jmp $ ; hang

DISK_ERROR_MSG: db "Read error.", 0