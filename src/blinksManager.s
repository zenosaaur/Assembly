.section .bss
    input: .skip 2
.section .text
	.global blinkManagers
	.type blinkManagers, @function
blinkManagers:
    push %ebp
    movl %esp, %ebp
    addl $-4, %esp

    movl $3, %eax
    movl $0, %ebx
    leal input,%ecx
    movl $1, %edx
    int $0x80
    jmp cmpStart
    /*cmpl $10, %eax
    je fineBack
    jg cmpStart*/

cmpStart:
    movl input,%eax
    movl %eax,-4(%ebp)
    cmpl $50, input
    jl min2
    jg max2
    je equal2

equal2:
    jmp fine

min2:
    movl $50, %eax
    jmp fine

max2:
    cmpl $53, %eax
    jle fine
    jg max5

max5:
    movl $53, %eax
    jmp fine

fineBack:
    movl -4(%ebp) , %eax
    # routine per svuotare lo stack
    xorl %ecx, %ecx
    xorl %edx, %edx
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret

fine:
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $1, %edx
    int $0x80

    movl -4(%ebp) , %eax
    # routine per svuotare lo stack
    xorl %ecx, %ecx
    xorl %edx, %edx
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret
