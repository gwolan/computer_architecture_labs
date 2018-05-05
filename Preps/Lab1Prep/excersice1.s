#Program reads text input and switches letters case

.data
READ = 0
WRITE = 1
STDIN = 0
STDOUT = 1
EXIT = 60
EXIT_SUCC = 0
BUF_LEN = 512

.bss
.lcomm textIn, 512

.text
.globl _start


_start:
movq $READ, %rax
movq $STDIN, %rdi
movq $textIn, %rsi
movq $BUF_LEN, %rdx
syscall

movq %rax, %r8
movq $0, %rdi




read_letter:
movb textIn(, %rdi, 1), %al
cmpb $'A', %al
jge check_if_upper
jmp next_letter



check_if_upper:
cmpb $'Z', %al
jle switch_to_lower
cmpb $'a', %al
jge check_if_lower
jmp next_letter

check_if_lower:
cmpb $'z', %al
jle switch_to_upper
jmp next_letter



switch_to_lower:
addb $0x20, %al
jmp next_letter

switch_to_upper:
subb $0x20, %al



next_letter:
movb %al, textIn(, %rdi, 1)
incq %rdi
cmpq %r8, %rdi
jl read_letter




movq $WRITE, %rax
movq $STDOUT, %rdi
movq $textIn, %rsi
movq $BUF_LEN, %rdx
syscall




movq $EXIT, %rax
movq $EXIT_SUCC, %rdi
syscall
