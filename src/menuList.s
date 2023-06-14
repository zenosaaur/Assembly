.extern isSupervisor

.section .data
    menu1: .ascii  "1) Setting automobile"
    lenMenu1: .long . - menu1
    menu2: .ascii  "2) Data: 26/05/2023\n"
    lenMenu2: .long . - menu2
    menu3: .ascii  "3) Ora: 14:32\n"
    lenMenu3: .long . - menu3
    menu4: .ascii  "4) Blocco automatico porte"
    lenMenu4: .long . - menu4
    menu5: .string  "5) Back-home"
    lenMenu5: .long . - menu5
    menu6: .ascii  "6) Check olio\n"
    lenMenu6: .long . - menu6
    menu7: .string  "7) Frecce direzione: "
    lenMenu7: .long . - menu7
    menu8: .ascii  "8) Reset pressione gomme\n"
    lenMenu8: .long . - menu8
    supervisorTag: .ascii " (supervisor)\n"
    lenSupervisorTag: .long . - supervisorTag

.section .text
	.global menuList
	.type menuList, @function
menuList:
    push %ebp
    movl %esp, %ebp
    movl 16(%ebp),%eax
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
    cmpl $6, %eax
    je counter6
    cmpl $7, %eax
    je counter7

counter0:
    movl $4, %eax
    movl $1, %ebx
    leal menu1,%ecx
    movl lenMenu1, %edx
    int $0x80
    movl $0,%eax
    cmpl $1,supervisor
    je printSupervisor
    call newLine
    jmp end
printSupervisor:
    movl $4, %eax
    movl $1, %ebx
    leal supervisorTag,%ecx
    movl lenSupervisorTag, %edx
    int $0x80
    jmp end
counter1:
    movl $4, %eax
    movl $1, %ebx
    leal menu2,%ecx
    movl lenMenu2, %edx
    int $0x80
    movl $0,%eax
    jmp end
counter2:
    movl $4, %eax
    movl $1, %ebx
    leal menu3,%ecx
    movl lenMenu3, %edx
    int $0x80
    movl $0,%eax
    jmp end
counter3:
    # stampo la stringa 'Blocco automatica porte'
    movl $4, %eax
    movl $1, %ebx
    leal menu4,%ecx
    movl lenMenu4, %edx
    int $0x80
    call printMoreOptionONOFF
    movl $0,%eax
    jmp end
counter4:
    movl $4, %eax
    movl $1, %ebx
    leal menu5,%ecx
    movl lenMenu5, %edx
    int $0x80
    call printMoreOptionONOFF
    movl $0,%eax
    jmp end
counter5:
    movl $4, %eax
    movl $1, %ebx
    leal menu6,%ecx
    movl lenMenu6, %edx
    int $0x80
    movl $0,%eax
    jmp end
counter6:
    movl $4, %eax
    movl $1, %ebx
    leal menu7,%ecx
    movl lenMenu7, %edx
    int $0x80
    call printMoreOptionFreccia
    jmp end
counter7:
    cmpl $1, 12(%ebp)
    je moreOptionPressione
    movl $4, %eax
    movl $1, %ebx
    leal menu8,%ecx
    movl lenMenu8, %edx
    int $0x80
    xorl %eax,%eax
    jmp end
    moreOptionPressione:
        call printMoreOptionPressione
        xorl %eax,%eax
        jmp end
end:
    xorl %ebx,%ebx
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret


