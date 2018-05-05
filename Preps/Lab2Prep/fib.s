#Program calculates Nth Fibonacci number.
#N number is read from standard input and
#has dynamic range of one byte (0 - 255).

.data
READ = 0
WRITE = 1
STDIN = 0
STDOUT = 1
EXIT = 60
EXIT_SUCC = 0
BUF_LEN = 1024

inputN: .byte 0x00


.bss
.lcomm prev_result, BUF_LEN
.lcomm result, BUF_LEN


.text
.globl _start



_start:
movq $READ, %rax
movq $STDIN, %rdi
movq $inputN, %rsi
movq $1, %rdx
syscall

#movb (inputN), %cl
cmpb $0, (inputN)
je write_result
movq $0, %rdi
cmpb $2, (inputN)
jle ret_one



movb $1, prev_result(, %rdi, 1)
movb $1, result(, %rdi, 1)
movb $2, %cl
clc #clear carry
pushf #save flags state

calculate_next_fibonacci:
incb %cl
movq $0, %rdi

	add_prev_to_current:
	movb prev_result(, %rdi, 1), %al
	movb result(, %rdi, 1), %bl
	movb %bl, %dl #save current result for prev_result
	
	popf #get carry state
	adcb %al, %bl
	pushf
	movb %bl, result(, %rdi, 1)
	movb %dl, prev_result(, %rdi, 1)
	incq %rdi
	cmpq $BUF_LEN, %rdi
	jl add_prev_to_current

cmpb (inputN), %cl
jl calculate_next_fibonacci


xorq %rdi, %rdi
movq $BUF_LEN, %rsi
decq %rsi

set_result_to_little_endian:
movb result(, %rdi, 1), %al
movb result(, %rsi, 1), %bl
movb %al, result(, %rsi, 1)
movb %bl, result(, %rdi, 1)
incq %rdi
decq %rsi
cmpq %rsi, %rdi
jle set_result_to_little_endian
jmp write_result



ret_one:
movb $1, result(, %rdi, 1)

write_result:
movq $WRITE, %rax
movq $STDOUT, %rdi
movq $result, %rsi
movq $BUF_LEN, %rdx
syscall


movq $EXIT, %rax
movq $EXIT_SUCC, %rdi
syscall
