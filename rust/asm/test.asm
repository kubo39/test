bits 64

global plus_one

section .text

%macro epilog 0
        ret
%endmacro

plus_one:
        add rdi, 1
        mov rax, rdi
        epilog
