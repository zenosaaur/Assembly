.section .data
    input: .ascii "0000"
.section .text
	.global getArrow
	.type getArrow, @function

getArrow:
    push %ebp
    movl %esp, %ebp
    addl $-4, %esp
    scanArrow1: # controllo carattere '^'
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        leal input, %esi
        xorl %ecx,%ecx
        movb (%ecx,%esi,1) , %bl
        cmpb $10, %bl
        je checkEscapeCommand
        continueInserimento:
            cmpb $27, %bl
            je scanArrow2
            jmp scanArrow1
        
    scanArrow2:#controllo carattere '['
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        leal input, %esi 
        xorl %ecx,%ecx
        movb (%ecx,%esi,1) , %bl
        cmpb $91, %bl 
        je scanArrow3
        jmp scanArrow1
        
    scanArrow3:
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        leal input, %esi 
        xorl %ecx,%ecx
        movb (%ecx,%esi,1) , %bl
        cmpb $65, %bl 
        jge subCntrl
        jmp scanArrow1

    subCntrl:
        cmpb $67, %bl
        jg wrongArrow  
        movb %bl, %al
        # inseriesco l valore nello stack
        movl %eax,-4(%ebp)
        jmp backspace
        
    backspace:# scanf per \n
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        leal input, %esi 
        xorl %ecx,%ecx
        movb (%ecx,%esi,1) , %bl
        cmpb $10, %bl
        je fine
        jmp scanArrow1
    wrongArrow:
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        jmp scanArrow1   
    checkEscapeCommand:
        cmpl $1, 8(%ebp)
        je continue
        jmp continueInserimento
    continue:
        movl $10, -4(%ebp)

fine:
    # routine per svuotare lo stack
    movl -4(%ebp), %eax
    xorl %ecx, %ecx
    xorl %edx, %edx
    addl $8, %esp
    movl %ebp, %esp
    pop %ebp

    ret
