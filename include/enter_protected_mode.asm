;	enter_pm
;	enters 32-bit protected mode
;	IMPORTANT: relies on the pre-inclusion of global_descriptor_table.asm

[bits 16]

enter_pm:
	cli
	lgdt [gdt_descriptor] ; load the GDT

	mov eax, cr0 ; set the first bit of control register 0
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEGMENT:init_pm

[bits 32]

init_pm:
	mov ax, DATA_SEGMENT
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000 ; set the stack to a safe (32-bit) address
	mov esp, ebp

	call BEGIN_PM ; BEGIN_PM must exist somewhere in the including file