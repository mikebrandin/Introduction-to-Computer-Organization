/*
Mike Brandin mbrandi
CPSC 2310-002 
Programming Assignment 3
07/28/21

Description: The main function parse cmd line args and call offset subroutine then print output.

r0:    many uses: parse cmd line args, carries row index before offset subroutine, after subroutine holds offset
r1:    column index (originally stores command line args)
r2:    # of columns          
r3:    holds offset value after copying from subroutine return 
r4:    stores command line arguements
r5:    temp value to store row index
r6:    temp value to store column index
r7:    temp value to store column size
*/
 	.file "main.s"
 	.text
 	.align 2
 	.global main
 	.type main, %function

main:
      push {r4-r7, lr}
      mov r4, r1 

      ldr r0, [r4, #4]        @ get row index from cmd line args then convert to integer
      bl atoi
      mov r5, r0
      ldr r0, [r4, #8]        @ get column index from cmd line args then convert to integer
      bl atoi
      mov r6, r0
      ldr r0, [r4, #12]       @ get # columns from cmd line args then convert to integer
      bl atoi
      mov r7, r0

      mov r0, r5              @ copy temp values back to r0-r2
      mov r1, r6
      mov r2, r7
      
      bl offset               @ call offset subroutine
      b print     

print:

      mov r3, r0              @ format ouput and copy temp values back to r1-r2
      ldr r0, =fmt_offset
      mov r1, r5
      mov r2, r6
      bl printf               @ print to stdout

      pop {r4-r7, pc}       
      mov r0, #0

      .section ".rodata"
fmt_offset:    .asciz "the offset for a[%d][%d] is %d\n/012/000"
