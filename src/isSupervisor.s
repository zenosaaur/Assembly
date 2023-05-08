
.section .data
    supervisorCode: .string  "2244"
    supervisor: .string  "menu supervisor"
    test2: .string  "menu normale"

.section .text
    .global _start

_start:
    movl 8(%esp), %eax
    pushl %ebp
    movl %esp, %ebp /*salvo in ebp il puntatore a esp*/
    movl 8(%ebp), %ebx /*argomento passato dalla funzione main 2244 o null*/
    /*comparazione*/
    cmp supervisorCode, %ebx 
    je isSupervisor
    jmp notSupervisor
        /*menu*/
isSupervisor:
    /*menuSupervisor*/
notSupervisor:
    /*menu*/
fine:
    movl $1, %eax
    int $0x80

