#Program reads text input and converts it into binary code.
#Only hexadecimal digits are accepted.

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
.lcomm valueOut, 512

.text
.globl _start


_start:
movq $READ, %rax
movq $STDIN, %rdi
movq $textIn, %rsi
movq $BUF_LEN, %rdx
syscall

movq %rax, %r8
movq $0, %rdi #textIn index
movq $0, %rsi #valueOut index
movq $0, %rcx #valueOut byte counter




read_letter:
movb textIn(, %rdi, 1), %al
cmpb $'0', %al
jge check_if_number
jmp read_next


check_if_number:
cmpb $'9', %al
jle calculate_number
cmpb $'A', %al
jge check_if_upper
jmp read_next


check_if_upper:
cmpb $'F', %al
jle switch_to_lower
cmpb $'a', %al
jge check_if_lower
jmp read_next

switch_to_lower:
addb $0x20, %al
jmp calculate_letter


check_if_lower:
cmpb $'f', %al
jle calculate_letter
jmp read_next


calculate_number:
subb $0x30, %al
jmp write_value

calculate_letter:
subb $0x57, %al
jmp write_value


write_value:
cmpq $0, %rcx
je shift_left

addb %al, valueOut(, %rsi, 1)
decq %rcx
incq %rsi
jmp read_next

shift_left:
shlb $4, %al
addb %al, valueOut(, %rsi, 1)
incq %rcx


read_next:
incq %rdi
cmpq %r8, %rdi
jl read_letter




movq $WRITE, %rax
movq $STDOUT, %rdi
movq $valueOut, %rsi
movq $BUF_LEN, %rdx
syscall




movq $EXIT, %rax
movq $EXIT_SUCC, %rdi
syscall
