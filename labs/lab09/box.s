@Mike Brandin CPSC 2310 Lab 9

box_init:
        push  {lr}
        sub   sp, sp, #12 @ allocate space for stack pointer

        str   r1, [sp]          @ store values in registers      
        str   r2, [sp, #4]
        str   r3, [sp, #8]

        ldmia sp, {r1, r2, r3}
        stmia r0, {r1, r2, r3}  @ store in r0

        add   sp, sp, #12 @ deallocate space
        pop   {pc}

init:
        push  {lr}
        sub   sp, sp, #8

        str   r1, [sp]
        str   r2, [sp, #4]

        ldmia sp, {r1, r2}
        stmia r0, {r1, r2}

        add   sp, sp, #8
        pop   {pc}

zero:
        push  {lr}
        sub   sp, sp, #8

        mov   r3, #0
        str   r3, [sp]
        str   r3, [sp, #4]

        ldmia sp, {r1, r2}
        stmia r0, {r1, r2}

        add   sp, sp, #8
        pop   {pc}

.global main
main:
        push   {lr}
        sub    sp, sp, #8 @ make room for the point struct

        mov    r0, sp
        mov    r1, #34
        mov    r2, #-3
        bl     init

        ldr    r0, =fmtstr1
        ldr    r1, [sp]
        ldr    r2, [sp, #4]
        bl     printf

        mov    r0, sp
        bl     zero

        ldr    r0, =fmtstr1
        ldr    r1, [sp]
        ldr    r2, [sp, #4]
        bl     printf
        
        add    sp, sp, #8
        sub    sp, sp, #12 @ make room for the box struct

        mov    r0, sp   
        mov    r1, #45  @ set values for registers
        mov    r2, #17
        mov    r3, #3
        bl     box_init @ call box_)init subroutine

        ldr    r0, =fmtstr2 @ format string and print
        ldr    r1, [sp]
        ldr    r2, [sp,#4]
        ldr    r3, [sp, #8]

        bl     printf

        add   sp, sp, #12 @ deallocate memory for box struct

        pop    {pc}

fmtstr1:
        .ascii "The members of the structure dot are %d, %d\012\000"	

fmtstr2:
        .ascii "The members of the structure box are %d, %d, %d\012\000" @ format the string for box	
