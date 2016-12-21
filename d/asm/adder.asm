bits 64

global adder

section .text

adder:
    add rdi, 1
    mov rax, rdi
    ret
