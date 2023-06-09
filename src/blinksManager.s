.section .data
    input: .ascii "00"
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
    leal input, %esi 
    xorl %ecx,%ecx
    movb (%ecx,%esi,1) , %bl
    cmpb $10, %bl
    je fineBack
    jg cmpStart

cmpStart:
    movb %bl,%al
    movl %eax,-4(%ebp)
    cmpb $50, %bl
    jl min2
    jg max2
    je equal2

equal2:
    jmp fine

min2:
    movl $50, -4(%ebp)
    jmp fine

max2:
    cmpl $53, -4(%ebp)
    jle fine
    jg max5

max5:
    movl $53, -4(%ebp)
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
