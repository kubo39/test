bits 64

global plus_one

section .text

plus_one:
    add rdi, 1
    mov rax, rdi
    ret
