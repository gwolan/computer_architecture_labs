#This code calculates N-th Fibonacci sequence.
# 
#Numbers index is read from standard input.


EXIT    	  = 1
READ    	  = 3
WRITE   	  = 4
STDIN   	  = 0
STDOUT  	  = 1
EXIT_SUCCESS  = 0
SYSCALL 	  = 0x80

INPUT_LENGTH  = 4
RESULT_LENGTH = 1024


.data
	inN: .long 0x00000000

.bss
	.lcomm result, RESULT_LENGTH

.globl _start




_start:
movl $READ,   		%eax
movl $STDIN,  		%ebx
movl $inN,    		%ecx
movl $INPUT_LENGTH, %edx
int  $SYSCALL



#if N=0 just return
cmpl $0, %eax
je write_output



write_output:
movl $WRITE,  %eax
movl $STDOUT, %ebx
movl $char,   %ecx
movl $BUFFER, %edx
int  $SYSCALL
jmp end



end:
movl $EXIT, 	    %eax
movl $EXIT_SUCCESS, %ebx
int  $SYSCALL

