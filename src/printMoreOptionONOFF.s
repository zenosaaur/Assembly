.section .data
    ON: .ascii ": ON\n"
    lenOn: .long . - ON
    OFF: .ascii ": OFF\n"
    lenOff: .long . - OFF
.section .text
	.global printMoreOptionONOFF
	.type printMoreOptionONOFF, @function
printMoreOptionONOFF:
    push %ebp
    movl %esp, %ebp
    # se nel registro eax c'e il valore 1 vado nella fase di modifica
    movl 20(%ebp), %eax
    cmpb $1, %al
    je moreOptionsONOFF
    # vado a capo
    call newLine
    movl %ebp, %esp
    pop %ebp
    ret
    moreOptionsONOFF:
        movl 16(%ebp), %eax
        cmpl $1,%eax
        je printOn
        call printOFF
        movl %ebp, %esp
        pop %ebp
        ret
    printOn:
        call printON
        movl %ebp, %esp
        pop %ebp
        ret


.type printON, @function
printON:
    push %ebp
    movl %esp, %ebp
    movl $4, %eax
    movl $1, %ebx
    leal ON,%ecx
    movl lenOn, %edx
    int $0x80
    movl %ebp, %esp
    pop %ebp
    ret
.type printOFF, @function
printOFF:
    push %ebp
    movl %esp, %ebp
    movl $4, %eax
    movl $1, %ebx
    leal OFF,%ecx
    movl lenOff, %edx
    int $0x80
    movl %ebp, %esp
    pop %ebp
    ret
