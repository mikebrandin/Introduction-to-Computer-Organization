//Mike Brandin CPSC 2310 LAB 6

	.global main

main:
	push {r7, lr}
	sub sp, sp, #16
	add r7, sp, #0

	ldr r0, =0x12345678       /* put the source value in r0 */
	ldr r2, =0x7              /* put the location of the field's lsb in r2 */
	ldr r3, =0x8              /* put the size of field in r3 */

/* Beginning of your code */

	lsr r0,r0,r2 							//shift r0 7 times to the right
	mov r1,#1									//move value of 1 to r1
	lsl r1,r1,r3							//shift r1 8 times to the left
	sub r1,r1,#1							//subtract 1 from r1
	and r1,r1,r0							//and mask

/* End of your code */

/* show output on screen */
    ldr r0, =prt_line
	bl printf
	add r7, r7, #16
	mov sp, r7
	pop {r7, pc}

	.size main, .-main
	.section .rodata

prt_line: .asciz "0x%X\n"
