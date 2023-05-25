

.section .data
    user: .ascii  "menu normale"
    lenUser: .long . - user
    arrowA: .string "\033[A\010"
    clear: .string "\033[1;1H\033[2J"
    lenClear: .long . - clear
    lenArrow: .long . - arrowA
    new_line_char:.byte 10
.section .text
	.global menu
	.type menu, @function

menu:
    call getArrow
    
    movl $1, %eax
	movl $0, %ebx
	int $0x80
