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
    menu4: .ascii  "Blocco automatico porte"
    lenMenu4: .long . - menu4
    menu5: .string  "Back-home"
    lenMenu5: .long . - menu5
    menu6: .ascii  "Check olio\n"
    lenMenu6: .long . - menu6
    menu7: .string  "Frecce direzione: "
    lenMenu7: .long . - menu7
    menu8: .ascii  "Reset pressione gomme\n"
    lenMenu8: .long . - menu8
    ON: .ascii ": ON\n"
    lenOn: .long . - ON
    OFF: .ascii ": OFF\n"
    lenOff: .long . - OFF
    newLine: .ascii "\n"
    lenNewLine: .long . - newLine
    lampeggio: .ascii "3"
    pressione: .ascii "Pressione gomme resettata\n"
    lenPressione: .long . - pressione
.section .text
	.global menuList
	.type menuList, @function


/*
Parametri:
    - MoreOptions ----> %eax
    - Porte/BackHome ----> %ebx
    - isSupervisor ----> %ecx
*/


menuList:
    push %ebp
    movl %esp, %ebp
    addl $-8, %esp
    movl %eax,-4(%ebp)
    movl %ebx,-8(%ebp)
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
    cmpl $1, -4(%ebp)
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


# utilities


.type printON, @function
printON:
    push %ebp
    movl %esp, %ebp
    movl $4, %eax
    movl $1, %ebx
    leal ON,%ecx
    movl lenOn, %edx
    int $0x80
    movl %ebp, %esp
    pop %ebp
    ret
.type printOFF, @function
printOFF:
    push %ebp
    movl %esp, %ebp
    movl $4, %eax
    movl $1, %ebx
    leal OFF,%ecx
    movl lenOff, %edx
    int $0x80
    movl %ebp, %esp
    pop %ebp
    ret
.type new_line, @function
new_line:
        push %ebp
        movl %esp, %ebp
        movl $4, %eax
        movl $1, %ebx
        leal newLine,%ecx
        movl lenNewLine, %edx
        int $0x80
        movl %ebp, %esp
        pop %ebp
        ret
.type printMoreOptionONOFF, @function
printMoreOptionONOFF:
    push %ebp
    movl %esp, %ebp
    # se nel registro eax c'e il valore 1 vado nella fase di modifica
    movl 12(%ebp), %eax
    cmpb $1, %al
    je moreOptionsONOFF
    # vado a capo
    call new_line
    movl %ebp, %esp
    pop %ebp
    ret
    moreOptionsONOFF:
        movl 8(%ebp), %eax
        cmpl $1,%eax
        je printOn
        call printOFF
        movl %ebp, %esp
        pop %ebp
        ret
    printOn:
        call printON
        movl %ebp, %esp
        pop %ebp
        ret

.type printMoreOptionFreccia, @function
printMoreOptionFreccia:
    push %ebp
    movl %esp, %ebp
    movl 12(%ebp),%ebx
    cmpl $1, %ebx
    je continue
        call new_line
        xorl %eax,%eax
        movl %ebp, %esp
        pop %ebp
        ret
    continue:
        movl 8(%ebp), %ebx
        cmpl $0, %ebx
        jg setBlinks
        jmp moreOptionsFreccia
    setBlinks:
        movl %ebx, lampeggio
        moreOptionsFreccia:
            movl $4, %eax
            movl $1, %ebx
            leal lampeggio,%ecx
            movl $1, %edx
            int $0x80

            call new_line
            movl $1,%eax
            movl %ebp, %esp
            pop %ebp
            ret
.type printMoreOptionPressione, @function
printMoreOptionPressione:
    push %ebp
    movl %esp, %ebp
    movl $4, %eax
    movl $1, %ebx
    leal pressione,%ecx
    movl lenPressione, %edx
    int $0x80
    movl %ebp, %esp
    pop %ebp
    ret
