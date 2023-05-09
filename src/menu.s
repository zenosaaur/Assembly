.section .data
    user: .string  "menu normale"
    lenUser: .long . - user
    new_line_char:.byte 10

.section .text
	.global menu
	.type menu, @function

menu:
    movl $4, %eax
	movl $1, %ebx
	leal user, %ecx
	movl lenUser, %edx
	int $0x80

    movl $4, %eax
	movl $1, %ebx
	leal new_line_char, %ecx
	movl $1, %edx
	int $0x80

    movl $1, %eax
	movl $0, %ebx
	int $0x80
