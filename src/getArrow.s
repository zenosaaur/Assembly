/*Funzione che non prende nessun parametro, 
che ha la funzionalita di restiture un numero 
da 1-4 in caso fosse premuto una freccia direzionale 
in caso contrario restituisce 0 */




.section .data
    clear: .ascii "\033[1;1H\033[2J"
    input: .ascii ""
    lenClear: .long . - clear
.section .text
	.global getArrow
	.type getArrow, @function

getArrow:
    push %ebp
    movl %esp, %ebp
    addl $-4, %esp

    scanArrow1:#controllo carattere '^'
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        cmpl $27, input 
        je scanArrow2
        jmp error
        
    scanArrow2:#controllo carattere '['
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        cmpl $91, input 
        je scanArrow3
        jmp error
        
    scanArrow3:
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        cmpl $65, input 
        jge subCntrl
        jl error
    subCntrl:
        cmpl $68, input
        jg error  
        # salvo  il valore preso in input e gli sottraggo 64 e 
        # non 63 cosi do non avere il regsitro a 0(valore di default )
        movl input, %eax
        subl $64, %eax
        # inseriesco l valore nello stack
        movl %eax,-4(%ebp)
    
        # scanf per \n
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        cmpl $10, input
        je fine
        jmp error

    error:
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        cmpl $10, input
        movl $0, -4(%ebp)
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
