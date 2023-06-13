.section .data
    supervisorCode: .ascii  "2244\0"
    .global supervisor 
        supervisor: .long 0 

.section .text
	.global isSupervisor
	.type isSupervisor, @function
isSupervisor:
    push %ebp
    movl %esp, %ebp
    movl 8(%ebp),%ecx
    testl %ecx, %ecx
    jz userRedirect
    movl (%ecx), %eax
    cmpl %eax, supervisorCode
    je supervisorRedirect
userRedirect:
    movl $0, supervisor
    jmp fine
supervisorRedirect:
    movl $1, supervisor
    jmp fine

fine:
    movl %ebp, %esp
    pop %ebp
    ret
