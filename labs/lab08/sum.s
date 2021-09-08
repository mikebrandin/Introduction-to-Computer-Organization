@ Mike Brandin CPSC 2310-002 Lab 8
    .file "sum.s"
    .text
    .align  2
    .global main
    .type   main, %function

/* main() sums 10 values from stdin and prints the sum */
main:
    push {lr}    // save lr 
    //Code goes here

    sub sp, sp, #40 @ allocate space for stack pointer (4 * number of values (10))
    mov r4, #0      @ set sum to 0
    mov r5, sp      @ set to sp
    mov r6, #10     @ set number of input values

loop_read:          @ read from file and push onto stack
    cmp r6, #0      
    beq done_read   @ if limit is reached branch to done_read

    ldr r0, =rdfmt  @ format then  call scanf
    mov r1, r5
    bl scanf        
    add r5, r5, #4  @ increment space for bytes and decrement limit down 1
    sub r6, r6, #1  
    b loop_read     @ loop back

done_read:
    mov r5, sp      @ reset stack pointer temp value and limit value
    mov r6, #10

loop_sum:           @ loop to calculate sum
    cmp r6, #0      
    beq done_sum    @ if limit is reached branch to done_sum   

    ldr r0,[r5]     @ load register r5 into r0
    add r4, r4, r0  @ calculate sum, increment space for bytes, and decrement limit
    add r5, r5, #4
    sub r6, r6, #1
    b loop_sum      @ loop back

done_sum:           
    ldr r0, =prtfmt @ format sum and print to stdout
    mov r1, r4
    bl printf

    add sp, sp, #40 @ deallocate space used for sp
    mov r0, #0      
    pop {pc}         // put lr in pc    

.section    .rodata
    rdfmt:        .asciz "%d"
    prtfmt:       .asciz "sum is %d\n"
