/*
Mike Brandin mbrandi
CPSC 2310-002 
Programming Assignment 3
07/28/21

Description: The offset function will calculate the offset value.

r0:    row index
r1:    column index
r2:    # of columns           
r4:    temp value in calculating offset
r7:    size of integer
*/
       .file "offset.s"
	.text
	.align	2
	.global offset
	.type offset, %function

offset:
       mov r7, #4           @ set to sizeof(int)
       mul r4, r0, r2       @ multiply row index * # of columns
       add r4, r4, r1       @ add column index to offset      
       mul r0, r4, r7       @ multiply temp value by 4 (size of an integer) and store in r0

       bx lr                

