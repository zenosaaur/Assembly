
.section .data
    supervisorCode: .string  "2244"
    supervisor: .string  "menu supervisor"
    lenSupervisor: .long . - supervisor
    user: .string  "menu normale"
    lenUser: .long . - user
    new_line_char:
	.byte 10

.section .text
    .global _start

_start:
    popl %ecx /*Scarto i primi due elementi 
                dello Stack che contiene il numero 
                di parametri e il comando ./eseguibile
                */
    popl %ecx
adminMenager:
    popl %ecx  /*Dominio: 2244(admin user), null*/
    testl %ecx, %ecx
    jz userRedirect
    cmp %ecx, %ecx
    je supervisorRedirect
supervisorRedirect:
    movl $4, %eax
	movl $1, %ebx
	leal supervisor, %ecx
	movl lenSupervisor, %edx
	int $0x80

    movl $4, %eax
	movl $1, %ebx
	leal new_line_char, %ecx
	movl $1, %edx
	int $0x80
    jmp fine
userRedirect:
    movl $4, %eax
	movl $1, %ebx
	leal user, %ecx
	movl lenUser, %edx
	int $0x80

    movl $4, %eax
	movl $1, %ebx
	leal new_line_char, %ecx
	movl $1, %edx
	int $0x80
    jmp fine
fine:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

# --------FUNZIONI---------
.type printArgs, @function 	#  Stampa stringa
printArgs:
    # Cose  necessarie: il numero di caratteri
    call countChar
    movl $4, %eax
    movl $1, %ebx
    
    int $0x80

    # stamp o 
    movl $4, %eax
	movl $1, %ebx
	leal new_line_char, %ecx
	movl $1, %edx
	int $0x80
	

# --------------------------------------
.type countChar, @function			

countChar:
	xorl %edx, %edx # il contenuto del risultato viene salavato in %edx

iterate:
	movb (%ecx,%edx), %al 			# mette il carattere della stringa in al
	testb %al, %al 					# se il carattere è 0 (\0) la stringa è finita
	jz end_count				
	incl %edx
	jmp iterate

end_count:
	ret
