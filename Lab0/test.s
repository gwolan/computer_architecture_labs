#This file is containing simple read-write program
#in assembler language. Program is written on x64
#architecture and propably is going to expand for
#extra functionalities.

#Just a new blank comment.

#And another one.

EXIT    	 = 1
READ    	 = 3
WRITE   	 = 4
STDIN   	 = 0
STDOUT  	 = 1
SYSCALL 	 = 0x80
EXIT_SUCCESS = 0
BUFFER       = 1

.data
	char: .byte 0x00


.globl _start


_start:
movl $READ,   %eax
movl $STDIN,  %ebx
movl $char,   %ecx
movl $BUFFER, %edx
int  $SYSCALL


cmpl $0, %eax
je end


movl $WRITE,  %eax
movl $STDOUT, %ebx
movl $char,   %ecx
movl $BUFFER, %edx
int  $SYSCALL

jmp _start


end:
movl $EXIT, 	    %eax
movl $EXIT_SUCCESS, %ebx
int  $SYSCALL