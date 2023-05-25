/*Funzione che non prende nessun parametro, 
che ha la funzionalita di restiture un numero 
da 1-4 in caso fosse premuto una freccia direzionale 
in caso contrario restituisce 0 */




.section .data
    arrowA: .long 65
    arrowB: .long 66
    arrowC: .long 67
    arrowD: .long 68
    clear: .ascii "\033[1;1H\033[2J"
    input: .ascii ""
    lenClear: .long . - clear
    lenArrow: .long . - arrowA
.section .text
	.global getArrow
	.type getArrow, @function

getArrow:
    push %ebp
    movl %esp, %ebp
    # indice del loop aka int i = 0
    mov $3, %ecx  
    scanArrow:

        movl $3, %eax  
        movl $1, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        
        movl $3, %eax  
        movl $1, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80
        
        movl $3, %eax  
        movl $1, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80


        # idea 1 = A, 2 = B
        cmpb arrowA,$65
        je arrowAHandler
        cmp arrowB,input
        je arrowBHandler
        cmp arrowC,input
        je arrowDHandler
        cmp arrowD,input
        je arrowDHandler

        jmp fine

fine:
    movl %ebp, %esp
    pop %ebp

    ret


arrowAHandler:
        movb $1, %al
        jmp fine
arrowBHandler:
        movb $2, %al
        jmp fine
arrowCHandler:
        movb $3, %al
        jmp fine
arrowDHandler:
        movb $4, %al
        jmp fine
