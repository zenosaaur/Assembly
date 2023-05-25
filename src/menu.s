

.section .data
    user: .ascii  "menu normale"
    lenUser: .long . - user
    freccia: .ascii "0"
    new_line_char:.byte 10
.section .text
	.global menu
	.type menu, @function

menu:
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
    ret



arrowAHandler:
        subb $1, freccia
        jmp menu
arrowBHandler:
        subb $2, freccia
        jmp fine
arrowCHandler:
        subb $3, freccia
        jmp fine
arrowDHandler:
        subb $4, freccia
        jmp fine

