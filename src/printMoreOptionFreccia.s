.section .data
    lampeggio: .ascii "3"
.section .text
	.global printMoreOptionFreccia
	.type printMoreOptionFreccia, @function
printMoreOptionFreccia:
    push %ebp
    movl %esp, %ebp
    movl 20(%ebp),%ebx
    cmpl $1, %ebx
    je continue
        call newLine
        xorl %eax,%eax
        movl %ebp, %esp
        pop %ebp
        ret
    continue:
        movl 16(%ebp), %ebx
        cmpl $0, %ebx
        jg setBlinks
        jmp moreOptionsFreccia
    setBlinks:
        movl %ebx, lampeggio
        moreOptionsFreccia:
            movl $4, %eax
            movl $1, %ebx
            leal lampeggio,%ecx
            movl $1, %edx
            int $0x80

            call newLine
            movl $1,%eax
            movl %ebp, %esp
            pop %ebp
            ret
