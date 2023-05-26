

.section .data
    user: .ascii  "menu normale"
    lenUser: .long . - user
    freccia: .ascii "0"
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
    cmpb $49, freccia
    je arrowAHandler
    cmpb $50, freccia
    je arrowBHandler    
    cmpb $51, freccia
    je arrowCHandler    
    cmpb $52, freccia
    je arrowDHandler

fine:
    addl $4, %esp
    movl %ebp, %esp
    pop %ebp
    ret



arrowAHandler:
        subb $1, freccia
        # semplicemente verra incrementato un contatore che serve per scorrere i vari menu ricordarsi che sono ciclici
        cmpl $0,-4(%ebp)
        je returnToButtom 
        decl -4(%ebp)
        jmp loopArrow
        returnToButtom:
            addl $5, -4(%ebp) 
            jmp loopArrow

arrowBHandler:
        subb $2, freccia
        # incremento del contatore 
        jmp fine
arrowCHandler:
        subb $3, freccia
        # modifica una variabile che chiamata moreOptions
        jmp loopArrow
arrowDHandler:
        subb $4, freccia
        jmp loopArrow

