
.extern isSupervisor

.section .data
    user: .ascii  "menu normale"
    lenUser: .long . - user
    freccia: .ascii "0"
    porte: .long 0
    frecce: .long 0
    pressione: .long 0
    moreOption: .long 0
    backHome: .long 0
    limitOfMenu: .long 5

.section .text
	.global menu
	.type menu, @function

menu:
    push %ebp
    movl %esp, %ebp
    # riservo spazio per le varaibili 
    addl $-4, %esp
    # questo e lo spazio dedeicato all contatore del menu
    movl $0, -4(%ebp)
    cmpl $0, supervisor
    je loopArrow
    movl $7, limitOfMenu
loopArrow:
    call menuList
    cmpl $1, moreOption
    je compareAnd
    jmp continue
    compareAnd:
        cmpl $6 , -4(%ebp)
        je blinks
        jmp continue
    continue:
        movl moreOption, %eax
        call getArrow
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
        movb %al , frecce
        movl frecce , %ebx
        movl $1,%eax
        movl %eax, moreOption
        jmp loopArrow
    reset:
        movl $0, %eax
        movl $0, moreOption
        jmp loopArrow   
fine:
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret



arrowAHandler:
        subb $65, freccia
        # semplicemente verra incrementato un contatore che serve per scorrere i vari menu ricordarsi che sono ciclici
        cmpl $1,moreOption
        je modifyOption1
menuDecremnt:
        cmpl $0,-4(%ebp)
        je returnToBottom 
        decl -4(%ebp)
        jmp loopArrow
        returnToBottom:
            movl limitOfMenu,%ecx
            addl %ecx, -4(%ebp)
            jmp loopArrow
        modifyOption1:
            movl moreOption, %eax
            cmpl $3,-4(%ebp)
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
        cmpl %ecx ,-4(%ebp)
        je returnToTop 
        incl -4(%ebp)
        jmp loopArrow
        returnToTop:
            movl $0, -4(%ebp)
            jmp loopArrow
        modifyOption2:
            movl moreOption, %eax
            cmpl $3,-4(%ebp)
            je callPorte1
            callBack1:
                call optionBack
                jmp loopArrow
            callPorte1:
                call optionPorte
                jmp loopArrow
arrowCHandler:
        subb $67, freccia
        # se il contatore dello stack è:
        #   -  3 entro nel menu delle porte
        #   -  4 entro nel menu back home
        #   -  6 entro nel menu freccia direzione
        #   -  7 entro nel menu della pressione gomme
        cmpl $3, -4(%ebp)
        je moreOptionPorte
        cmpl $4, -4(%ebp)
        je moreOptionBack
        cmpl $6, -4(%ebp)
        je moreOptionFrecce
        cmpl $7, -4(%ebp)
        je moreOptionPressione
        jmp loopArrow
        moreOptionPorte:
            movl $1,%eax
            movl porte , %ebx
            movl %eax, moreOption
            jmp loopArrow
        moreOptionBack:
            movl $1,%eax
            movl backHome , %ebx
            movl %eax, moreOption
            jmp loopArrow
        moreOptionFrecce:
            movl $1,%eax
            movl frecce , %ebx
            movl %eax, moreOption
            jmp loopArrow
        moreOptionPressione:
            movl $1,%eax
            movl pressione , %ebx
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
