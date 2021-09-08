/*
Mike Brandin mbrandi
Kyree Herron kyreeh
CPSC 2310
Programming Assignment 4
08/01/21

Description: 

        
r0 - address of input string
r1 - address of output string
r2 - address of key string
r3 - encode/decode switch
		r3 == 0 means encode
		r3 == 1 means decode
r4 - holds the key bytes
r5 - holds input bytes
r6 - offset for the input
r7 - offset for the key

*/
       .file "encode.s"
	.text
	.align	2
	.global encode
	.type encode, %function

encode:
	push {r4-r7, lr}

	mov r6, #0					@ offset

	cmp r3, #1					@ if the third parameter passed to encode() is 1 branch to decode
	beq decode					@ maybe also check if not equal to zero and display error msg?


reset_key:
	mov r7, #0					@ set the key offset to 0

encode_loop:  					@ encode loop

	ldrb r5, [r2, r7]			@ load key byte in r5
	cmp r5, #0					@ if the byte is equal to eol reset the key offset to 0 b/c key needs to loop
	beq reset_key
	
	cmp r5, #32					@ if the key byte is a space DO NOT add with r4 (input byte)
	beq skip_space
	sub r5, r5, #96				@ subtract 96 so that a = 1 (not necessary but simplifies later logic)

	ldrb r4, [r0, r6]	 		@ load input byte in r4	
	cmp r4, #0			 		@ if the byte is equal to eol encoding is finished
	beq done

	cmp r4, #32					@ if byte is a space, skip the addition and store the space
	beq skip
	sub r4, r4, #96				@ subtract 96 so that a = 1 (not neccessary but simplifies later logic)

	add r4, r4, r5				@ add key byte to input byte

	cmp r4, #26					@ if result is greater than 26, subtract 26
	bgt reset_alpha
store:
	add r4, r4, #96				@ add 96 after subtraction to make asci value of 1 = a
skip:

	strb r4, [r1, r6]			@ store value in r1 at offset position
	add r6, r6, #1				@ increment offsets for key and input
	add r7, r7, #1

	b encode_loop				@ end of encode loop
	
reset_alpha:					@ reset sum of r4 and r5 to be within range of letters a-z	
	sub r4, r4, #26
	bl store

skip_space:
	ldrb r4, [r0, r6]	 		@ load input byte	
	cmp r4, #0			 		@ finish encoding if at eol
	beq done

	strb r4, [r1, r6]			@ store value in r1 at offset position
	add r6, r6, #1				@ increment offsets for key and input
	add r7, r7, #1
	bl encode_loop				@ continue the encode loop


decode: 						@ branched to if r3 = 1		

	d_reset_key:				
	mov r7, #0					@ set the key offset to 0

decode_loop:  					@ decode loop

	ldrb r5, [r2, r7]	 		@ load key byte in r5
	cmp r5, #0					@ if the byte is equal to eol reset the key offset to 0 b/c key needs to loop
	beq d_reset_key
	
	cmp r5, #32					@ if the key byte is a space DO NOT subtract with r4 (input byte)
	beq d_skip_space

	sub r5, r5, #96				@ subtract 96 so that a = 1 (not necessary but simplifies later logic)

	ldrb r4, [r0, r6]	 		@ load input byte in r4		
	cmp r4, #0			 		@ if the byte is equal to eol decoding is finished
	beq done

	cmp r4, #32					@ if byte is a space, skip the subtraction and store the space 
	beq dskip
	sub r4, r4, #96				@ subtract 96 so that a = 1 (not neccessary but simplifies later logic)

	sub r4, r4, r5				@ sub key byte to input byte

	cmp r4, #0					@ if result is less than/equal to 0, add 26
	ble d_reset_alpha
dstore:
	add r4, r4, #96				@ add 96 after subtraction to make asci value of 1 = a
dskip:

	strb r4, [r1, r6]			@ store value in r1 at offset position
	add r6, r6, #1				@ increment offsets for key and input
	add r7, r7, #1

	b decode_loop				@ end of encode loop

d_reset_alpha:					@ reset sum of r4 and r5 to be within range of letters a-z
	add r4, r4, #26
	bl dstore

d_skip_space:					@ complete decoding process without subtracting r4 and r5	
	ldrb r4, [r0, r6]	 			
	cmp r4, #0			 	
	beq done

	strb r4, [r1, r6]
	add r6, r6, #1
	add r7, r7, #1
	bl decode_loop

done: 							
	mov r4, #0;				   @ place an end of string character at the end of r1 and pop	
	strb r4, [r1, r6]
	mov r0, #0
	pop {r4-r7, pc}

