

.section .data
    user: .ascii  "menu normale"
    lenUser: .long . - user
    freccia: .ascii "0"
    porte: .long 0
    moreOption: .long 0
.section .text
	.global menu
	.type menu, @function

menu:
    push %ebp
    movl %esp, %ebp
    # riservo spazio per le varaibili 
    addl $-4, %esp
    movl $0, -4(%ebp)
loopArrow:
    call menuList
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
            addl $5, -4(%ebp) 
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

        cmpl $5,-4(%ebp)
        je returnToTop 
        incl -4(%ebp)
        jmp loopArrow
        returnToTop:
            movl $0, -4(%ebp) 
            jmp loopArrow
        jmp fine
arrowCHandler:
        subb $3, freccia
        movl $1,%eax
        movl porte , %ebx
        movl %eax, moreOption
        jmp loopArrow
arrowDHandler:
        subb $4, freccia
        movl $0, %eax
        movl %eax, moreOption
        jmp loopArrow

