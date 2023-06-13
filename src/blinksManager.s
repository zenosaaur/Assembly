.section .data
    input: .ascii "00"
    isNumber: .long 1
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
    movl $1,isNumber
    cmpb $10, %bl
    movb %bl,-4(%ebp)
    je fineBack
    pushl %ebx
    call isNumberFunction
    addl $4, %esp
    jmp validate
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
    jmp cmpStart
clearBuffer:
    pushl %ebx
    call isNumberFunction
    addl $4, %esp
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $1, %edx
    int $0x80
    leal input, %esi 
    xorl %ecx,%ecx
    movb (%ecx,%esi,1) , %bl
    cmpb $10,%bl
    je isNumberOrNot
    pushl %ebx
    call isNumberFunction
    addl $4, %esp
    jmp clearBuffer
isNumberOrNot:
    cmpb $1,isNumber
    je max5
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

.type isNumberFunction, @function
isNumberFunction:
    push %ebp
    movl %esp, %ebp
    movl 8(%ebp),%eax
    cmpl $48,%eax
    jl notNumber
    cmpl $57,%eax
    jg notNumber
    movl %ebp, %esp
    pop %ebp
    ret 
    notNumber:
        movl $0, isNumber
        movl %ebp, %esp
        pop %ebp
        ret

