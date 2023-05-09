.section .data
    supervisorCode: .string  "2244"

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
	call menuSupervisor
    jmp fine
userRedirect:
	call menu
    jmp fine
fine:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

# --------FUNZIONI----------------------------------
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
