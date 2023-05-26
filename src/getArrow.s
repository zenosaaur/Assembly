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
    scanArrow:

        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        
        # salvo  il valore preso in input e gli sottraggo 64 e 
        # non 63 cosi do non avere il regsitro a 0(valore di default )
        movl input, %eax
        subl $64,%eax
        # inseriesco l valore nello stack
        movl %eax ,-4(%ebp)

        # scanf per \n
        movl $3, %eax  
        movl $0, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80


        movl $4, %eax  
        movl $1, %ebx
        leal clear,%ecx  
        movl lenClear, %edx
        int $0x80


        jmp fine

fine:
    # routine per svuotare lo stack
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp

    ret
