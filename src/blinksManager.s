.section .data
    input: .ascii "00"
.section .text
	.global blinkManagers
	.type blinkManagers, @function
blinkManagers:
    push %ebp
    movl %esp, %ebp
    addl $-4, %esp

loopInput:
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
    jmp validate
andCondiction:
    cmpb $57, -4(%ebp)
    jg invalidInput
cmpStart:
    cmpb $50, -4(%ebp)
    jl min2
    jg max2
    je equal2

equal2:
    jmp fine

min2:
    movb $50, -4(%ebp)
    jmp fine

max2:
    cmpb $53,-4(%ebp)
    jle fine
    jg max5

max5:
    movb $53, -4(%ebp)
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
validate: 
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $1, %edx
    int $0x80
    leal input, %esi 
    xorl %ecx,%ecx
    movb (%ecx,%esi,1) , %bl
    cmpb $10, %bl
    jne clearBuffer
    cmpl $57, -4(%ebp)
    jg loopInput
    cmpl $48, -4(%ebp)
    jl loopInput
    jmp andCondiction
clearBuffer:
    cmpb $10,%bl
    je loopInput
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $1, %edx
    int $0x80
    leal input, %esi 
    xorl %ecx,%ecx
    movb (%ecx,%esi,1) , %bl
    cmpb $10, %bl
    jne clearBuffer
    jmp loopInput
invalidInput:
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $1, %edx
    int $0x80
    jmp loopInput
fine:
    movl -4(%ebp) , %eax
    # routine per svuotare lo stack
    xorl %ecx, %ecx
    xorl %edx, %edx
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret
