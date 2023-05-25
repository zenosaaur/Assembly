.section .data
    supervisor: .string  "menu supervisor"
    lenSupervisor: .long . - supervisor
    new_line_char:
	.byte 10

.section .text
	.global menuSupervisor
	.type menuSupervisor, @function

menuSupervisor:
    movl $4, %eax
	movl $1, %ebx
	leal supervisor, %ecx
	movl lenSupervisor, %edx
	int $0x80

    movl $4, %eax
	movl $1, %ebx
	leal new_line_char, %ecx
	movl $1, %edx
	int $0x80

    jmp menuSupervisor

    movl $1, %eax
	movl $0, %ebx
	int $0x80
