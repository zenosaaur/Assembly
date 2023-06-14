.section .data
    newLineChar: .ascii "\n"
    lenNewLine: .long . - newLineChar
.section .text
	.global newLine
	.type newLine, @function
newLine:
        push %ebp
        movl %esp, %ebp
        movl $4, %eax
        movl $1, %ebx
        leal newLineChar,%ecx
        movl lenNewLine, %edx
        int $0x80
        movl %ebp, %esp
        pop %ebp
        ret
