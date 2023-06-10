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
    movb %bl,-4(%ebp)
    je fineBack
    jg cmpStart

cmpStart:
    cmpb $50, %bl
    jl min2
    jg max2
    je equal2

equal2:
    jmp fine

min2:
    movb $50, %bl
    jmp fine

max2:
    cmpb $53, %bl
    jle fine
    jg max5

max5:
    movb $53, %bl
    jmp fine

fineBack:
    movb %bl,%al
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
