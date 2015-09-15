;; This program runs in 32-bit protected mode.
;  build: nasm -f elf -F stabs hello_world.asm
;  link:  ld -o hello-world-asm hello_world.o
; In 64-bit long mode you can use 64-bit registers (e.g. rax instead of eax,
; rbx instead of ebx, etc.)
; Also change "-f elf " for "-f elf64" in build command.

section .data                     ; section for initialized data
str:     db 'Hello world!', 0Ah   ; message string with new-line char at the
                                  ;  end (10 decimal)
str_len: equ $ - str              ; calcs length of string (bytes) by
                                  ; subtracting the str's start address from
                                  ; this address ($ symbol)

section .text       ; this is the code section
global _start       ; _start is the entry point and needs global scope to be
                    ; 'seen' by the linker - equivalent to main() in C/C++
_start:             ; definition of _start procedure begins here
  mov  eax, 4       ; specify the sys_write function code (from OS vector table)
  mov  ebx, 1       ; specify file descriptor stdout. In gnu/linux, everything's
                    ; treated as a file, even hardware devices
  mov  ecx, str     ; move start _address_ of string message to ecx register
  mov  edx, str_len ; move length of message (in bytes)
  int  80h          ; interrupt kernel to perform the system call we just set up.
                    ; in gnu/linux services are requested through the kernel
  mov  eax, 1       ; specify sys_exit function code (from OS vector table)
  mov  ebx, 0       ; specify return code for OS (zero indicates all is well)
  int  80h          ; interrupt kernel to perform system call (to exit)
