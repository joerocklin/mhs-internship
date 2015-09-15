;; This program runs in 32-bit protected mode.
;  build: nasm -f elf -F stabs hello_world.asm
;  link:  ld -o hello-world-asm hello_world.o
; In 64-bit long mode "-f elf64" for "-f elf" in build command.

section .data
str:     db 'Hello world!', 0Ah
str_len: equ $ - str

section .text
global _start

_start:
  mov  eax, 4
  mov  ebx, 1
  mov  ecx, str
  mov  edx, str_len
  int  80h
  mov  eax, 1
  mov  ebx, 0
  int  80h
