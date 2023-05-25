/*Funzione che non prende nessun parametro, 
che ha la funzionalita di restiture un numero 
da 1-4 in caso fosse premuto una freccia direzionale 
in caso contrario restituisce 0 */




.section .data
    test: .ascii "testA"
    lenTest: .long . - test
    clear: .ascii "\033[1;1H\033[2J"
    input: .ascii ""
    lenClear: .long . - clear
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

        movl $3, %eax  
        movl $1, %ebx
        leal input,%ecx  
        movl $1, %edx
        int $0x80

        movl $10, %ebx
        movl input, %eax
        div %bl
        subl $64,%eax


        jmp fine

fine:
    movl %ebp, %esp
    pop %ebp

    ret
