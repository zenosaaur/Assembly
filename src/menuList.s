/*
    File che ha il ruolo di contenitore la parte statica delle stringhe.
*/

.section .data
    menu1: .ascii  "Setting automobile\n"
    lenMenu1: .long . - menu1
    menu2: .ascii  "Data: 26/05/2023\n"
    lenMenu2: .long . - menu2
    menu3: .ascii  "Ora: 14:32\n"
    lenMenu3: .long . - menu3
    menu4: .ascii  "Blocco automatico porte:"
    lenMenu4: .long . - menu4
    menu5: .string  "Back-home:\n"
    lenMenu5: .long . - menu5
    menu6: .ascii  "Check olio\n"
    lenMenu6: .long . - menu6
    ON: .ascii "ON"
    lenOn: .long . - ON
    OFF: .ascii "OFF"
    lenOff: .long . - OFF
    newLine: .ascii "\n"
    lenNewLine: .long . - newLine
.section .text
	.global menuList
	.type menuList, @function


menuList:
    push %ebp
    movl %esp, %ebp
    addl $-4, %esp
    movl %eax,-4(%ebp)
    movl 8(%ebp),%eax
    cmpl $0, %eax
    je counter0
    cmpl $1, %eax
    je counter1
    cmpl $2, %eax
    je counter2
    cmpl $3, %eax
    je counter3
    cmpl $4, %eax
    je counter4
    cmpl $5, %eax
    je counter5

counter0:
    movl $4, %eax  
    movl $1, %ebx
    leal menu1,%ecx  
    movl lenMenu1, %edx
    int $0x80
    jmp end
counter1:
    movl $4, %eax  
    movl $1, %ebx
    leal menu2,%ecx  
    movl lenMenu2, %edx
    int $0x80
    jmp end
counter2:
    movl $4, %eax  
    movl $1, %ebx
    leal menu3,%ecx  
    movl lenMenu3, %edx
    int $0x80
    jmp end
counter3:
    movl $4, %eax  
    movl $1, %ebx
    leal menu4,%ecx  
    movl lenMenu4, %edx
    int $0x80
    movl -4(%ebp), %eax
    cmpb $1, %al
    je moreOptions
    jmp new_line
    moreOptions: 
        movl $4, %eax  
        movl $1, %ebx
        leal ON,%ecx  
        movl lenOn, %edx
        int $0x80
    new_line:
        movl $4, %eax  
        movl $1, %ebx
        leal newLine,%ecx  
        movl lenNewLine, %edx
        int $0x80
    jmp end
counter4:
    movl $4, %eax  
    movl $1, %ebx
    leal menu5,%ecx  
    movl lenMenu5, %edx
    int $0x80
    jmp end
counter5:
    movl $4, %eax  
    movl $1, %ebx
    leal menu6,%ecx  
    movl lenMenu6, %edx
    int $0x80
    jmp end
end:
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret
