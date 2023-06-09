
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
    cmpl $1, %eax
    je blinks
    call getArrow
    addb %al, freccia
     
    xorb %al,%al

    cmpb $49, freccia
    je arrowAHandler
    cmpb $50, freccia
    je arrowBHandler    
    cmpb $51, freccia
    je arrowCHandler    
    cmpb $52, freccia
    je arrowDHandler
    jmp loopArrow
blinks:
    call blinkManagers
    movl %eax,frecce
    movl frecce,%ebx
    movl $1,%eax
    jmp loopArrow   
fine:
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret



arrowAHandler:
        subb $1, freccia
        # semplicemente verra incrementato un contatore che serve per scorrere i vari menu ricordarsi che sono ciclici
        cmpl $1,moreOption
        je modifyOption1
menuIncrent:
        cmpl $0,-4(%ebp)
        je returnToBottom 
        decl -4(%ebp)
        jmp loopArrow
        returnToBottom:
            movl limitOfMenu,%ecx
            addl %ecx, -4(%ebp)
            jmp loopArrow
        modifyOption1:
            movl $1, %eax
            cmpl $1, porte
            je decremtOption1
            incremetOption1:
                incl porte
                movl $1,%ebx
                jmp loopArrow
            decremtOption1:
                decl porte
                xorl %ebx,%ebx
                jmp loopArrow
arrowBHandler:
        subb $2, freccia
        movl limitOfMenu,%ecx
        cmpl %ecx,-4(%ebp)
        je returnToTop 
        incl -4(%ebp)
        jmp loopArrow
        returnToTop:
            movl $0, -4(%ebp) 
            jmp loopArrow
        jmp fine
arrowCHandler:
        subb $3, freccia
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
arrowDHandler:
        subb $4, freccia
        movl $0, %eax
        movl %eax, moreOption
        jmp loopArrow
