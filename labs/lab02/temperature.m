comment(` Mike Brandin CPSC-2311 Lab Section 2')

                 comment(`this program prints out the a table of celsius ')
                 comment(`temperature values and their conversion to farenheit')
                 
iconst_1         comment(`push -40 onto stack')
bipush(-40)      
istore_1         comment(`store the counter that was at top of stack into')
                 comment(`local register 1 for safe keeping, this pops it at')
                 comment(`the same time.')

label(loop)      comment(`begining of loop')

iload_1          comment(`load register 1 values onto top of stack')
iconst_1         comment(`set the print statement to print local register 1, the loop count')
invokevirtual(1) comment(`1 == print with no new line') 

bipush(9)        comment(`multiply local register 1 entries by 9 then divide by 5 and then add 32')   
imul             
iconst_5
idiv
bipush(32)
iadd

istore_2         comment(`set the print statement to print local register 2, the farenheit value just calculated')
iconst_2
invokevirtual(2) comment(`2 == print with a new line at the end') 

iload_1          comment(`push the loop count onto the stack')
bipush(120)      comment(`push the loop limit  onto the stack')

iinc(1, 10)      comment(`increment local register 1 (our counter) by 10')

isub             comment(`pop top two numbers and subtract the 2nd from the 1st (loop count - 10)')

iflt(loop)       comment(`if top of stack < 0 goto loop, this also pops')

return
