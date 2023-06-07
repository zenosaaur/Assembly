.section .data
    input: .ascii "0\n"
    lenInput: .long . - input
.section .text

inserimento:
    movl $3, %eax
    movl $1, %ebx
    leal input, %ecx
    movl lenInput, %edx
    int $0x80
    cmp $2, %eax
    jl min2
    jg max2
    je equal2

equal2:
    movl %eax,-4(%ebp)
    jmp fine

min2:
    movl $2, %eax
    jmp fine

max2:
    cmp $5, %eax
    movl %eax,-4(%ebp)
    jle fine
    lg max5

max5:
    movl $5, %eax
    movl %eax,-4(%ebp)
    jmp fine
    
fine:
    # routine per svuotare lo stack
    movl -4(%ebp), %eax
    xorl %ecx, %ecx
    xorl %edx, %edx
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp

    ret
