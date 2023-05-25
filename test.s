    .section .data
prompt:
    .string "Inserisci una stringa: "
msg:
    .string "%c"
input:
    .skip 100

    .section .text
    .globl _start
_start:
    # stampa il prompt
    movl $4, %eax
    movl $1, %ebx
    movl $prompt, %ecx
    movl $22, %edx
    int $0x80

    # legge l'input
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl $100, %edx
    int $0x80

    # stampa la stringa
    movl $0, %eax
loop:
    movb input(%eax), %cl
    cmp $0, %cl
    je done
    pushl %eax
    movl $msg, %eax
    movl %cl, (%esp)
    movl $1, %edx
    movl $4, %ebx
    int $0x80
    popl %eax
    inc %eax
    jmp loop
done:
    # esce dal programma
    movl $1, %eax
    xor %ebx, %ebx
    int $0x80
