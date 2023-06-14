.section .data
    pressione: .ascii "Pressione gomme resettata\n\n"
    lenPressione: .long . - pressione
.section .text
	.global printMoreOptionPressione
	.type printMoreOptionPressione, @function
printMoreOptionPressione:
    push %ebp
    movl %esp, %ebp
    movl $4, %eax
    movl $1, %ebx
    leal pressione,%ecx
    movl lenPressione, %edx
    int $0x80
    movl %ebp, %esp
    pop %ebp
    ret
