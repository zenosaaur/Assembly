.section .data
userMsg:
    .string "Please enter a number: "
lenUserMsg = . - userMsg

dispMsg:
    .string "You have entered: "
lenDispMsg = . - dispMsg

.section .bss
num:
    .skip 2

.section .text
.globl _start

_start:
    # User prompt
    movl $4, %eax
    movl $1, %ebx
    movl $userMsg, %ecx
    movl $lenUserMsg, %edx
    int $0x80

    # Read and store the user input
    movl $3, %eax
    movl $2, %ebx
    movl $num, %ecx
    movl $2, %edx
    int $0x80

    # Output the message 'The entered number is: '
    movl $4, %eax
    movl $1, %ebx
    movl $dispMsg, %ecx
    movl $lenDispMsg, %edx
    int $0x80

    # Output the number entered
    movl $4, %eax
    movl $1, %ebx
    movl $num, %ecx
    movl $5, %edx
    int $0x80

    # Exit code
    movl $1, %eax
    movl $0, %ebx
    int $0x80
