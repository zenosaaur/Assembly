.extern isSupervisor

.section .data
    user: .ascii  "menu normale"
    lenUser: .long . - user
    freccia: .ascii "0"
    porte: .long 0
    lampeggio: .long 0
    moreOption: .long 0
    backHome: .long 0
    limitOfMenu: .long 5
    menuCounter: .long 0
.section .text
    .global _start

_start:
    popl %ecx
    popl %ecx
    popl %ecx
    pushl %ecx
    call isSupervisor
    addl $4,%esp
    cmpl $0, supervisor
    je loopArrow
    movl $7, limitOfMenu
loopArrow:
    pushl menuCounter
    pushl moreOption
    pushl %ebx
    call menuList
    addl $12,%esp
    cmpl $1, moreOption
    je compareAnd
    jmp continue
    compareAnd:
        cmpl $6 , menuCounter
        je blinks
        cmpl $7 , menuCounter
        je noInput
        jmp continue
    continue:
        pushl moreOption
        call getArrow
        addl $4,%esp
        movb %al, freccia
        
        xorb %al,%al

        cmpb $65, freccia
        je arrowAHandler
        cmpb $66, freccia
        je arrowBHandler    
        cmpb $67, freccia
        je arrowCHandler
        cmpb $10, freccia
        je deleteMoreOption
        jmp loopArrow
blinks:
    call blinkManagers
    # in evx ho il carattere di output
    cmpb $10,  %al
    je reset
        movb %al , lampeggio
        movl lampeggio , %ebx
        movl $1,%eax
        movl %eax, moreOption
        jmp loopArrow
    reset:
        movl $0, %eax
        movl $0, moreOption
        jmp loopArrow
noInput:
    movl $0, %eax
    movl $0, moreOption
    jmp loopArrow



arrowAHandler:
        subb $65, freccia
        # semplicemente verra incrementato un contatore che serve per scorrere i vari menu ricordarsi che sono ciclici
        cmpl $1,moreOption
        je modifyOption1
    menuDecremnt:
            cmpl $0,menuCounter
            je returnToBottom 
            decl menuCounter
            jmp loopArrow
            returnToBottom:
                movl limitOfMenu,%ecx
                addl %ecx, menuCounter
                jmp loopArrow
            modifyOption1:
                movl moreOption, %eax
                cmpl $3,menuCounter
                je callPorte2
                callBack2:
                    call optionBack
                    jmp loopArrow
                callPorte2:
                    call optionPorte
                    jmp loopArrow
arrowBHandler:
        subb $66, freccia
        # semplicemente verra incrementato un contatore che serve per scorrere i vari menu ricordarsi che sono ciclici
        cmpl $1,moreOption
        je modifyOption2
    menuIncrement:
            movl limitOfMenu,%ecx
            cmpl %ecx ,menuCounter
            je returnToTop 
            incl menuCounter
            jmp loopArrow
            returnToTop:
                movl $0, menuCounter
                jmp loopArrow
            modifyOption2:
                movl moreOption, %eax
                cmpl $3,menuCounter
                je callPorte1
                callBack1:
                    call optionBack
                    jmp loopArrow
                callPorte1:
                    call optionPorte
                    jmp loopArrow
arrowCHandler:
        subb $67, freccia
        cmpl $3, menuCounter
        je moreOptionPorte
        cmpl $4, menuCounter
        je moreOptionBack
        cmpl $6, menuCounter
        je moreOptionFrecce
        cmpl $7, menuCounter
        je moreOptionPressione
        jmp loopArrow
        moreOptionPorte:
            movl $1,%eax
            movl %eax, moreOption
            movl porte, %ebx
            jmp loopArrow
        moreOptionBack:
            movl $1,%eax
            movl %eax, moreOption
            movl backHome, %ebx
            jmp loopArrow
        moreOptionFrecce:
            movl $1,%eax
            movl %eax, moreOption
            movl lampeggio, %ebx
            jmp loopArrow
        moreOptionPressione:
            movl $1,%eax
            movl %eax, moreOption
            jmp loopArrow
deleteMoreOption:
    subb $10, freccia
    xorl %eax,%eax
    movl $0, moreOption       
    jmp loopArrow



.type optionPorte, @function
optionPorte:
    push %ebp
    movl %esp, %ebp
    cmpl $1, porte
    je decremtOptionPorte
    incremetOptionPorte:
        incl porte
        movl $1,%ebx
        movl %ebp, %esp
        pop %ebp
        ret
     decremtOptionPorte:
        decl porte
        movl $0,%ebx
        movl %ebp, %esp
        pop %ebp
        ret
.type optionBack, @function
optionBack:
    push %ebp
    movl %esp, %ebp
    cmpl $1, backHome
    je decremtOptionBack
    incremetOptionBack:
        incl backHome
        movl $1,%ebx
        movl %ebp, %esp
        pop %ebp
        ret
    decremtOptionBack:
        decl backHome
        movl $0,%ebx
        movl %ebp, %esp
        pop %ebp
        ret

