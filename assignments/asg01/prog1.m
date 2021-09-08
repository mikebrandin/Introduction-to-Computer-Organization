comment(` Mike Brandin CPSC-2310 Lab Section 2, Program 1, 07/10/21')
comment(` This program uses an accumulator machine to translate a binary ')
comment(` value (in this case 1101) to a decimal value (13)')


comment(` initialize variables')

	word(temp, 0) 		comment(` will be used to store the value of N when calculating remainder')
	word(two, 2) 			comment(` two = 2')
	word(ten, 10) 		comment(` ten = 10')
	word(N, 1101)			comment(` N = 1101, the binary value to be translated')
	word(decimal, 0)	comment(` the decimal value that will be calculated')
	word(base, 1)			comment(` stores the value of the 2^n where n represents the binary digit')
	word(digit, 1)		comment(` will store the remainder after temp modulus ten')

comment(` begin program')
label(start)
	load(N)
	store(temp)

comment(` while loop until N has value 0 (decimal value is calculated)')
label(loop)
	load(N)
	beq0(done)

	load(N)
	store(temp)

comment(` loop until the remainder is calculated for temp value')
label(modulus)
	load(temp)
	store(digit)
	sub(ten)
	blt0(mdone)
	add(ten)

	load(temp)
	sub(ten)
	store(temp)
	load(temp)
	store(digit)

	ba(modulus)

comment(` exit the loop for calculating remainder (digit having been stored)')
label(mdone)

comment(` set N equal to itself divided by 10')
	load(N)
	div(ten)
	store(N)

comment(` add to decimal sum by adding the remainder calculated multiplied by base')
	load(digit)
	mul(base)

	add(decimal)
	store(decimal)

comment(` incremement base by multiplying itself by two')
	load(base)
	mul(two)
	store(base)

	ba(loop)

comment(` exit loop for calculating decimal value')
label(done)

comment(` print out the calculated decimal value and terminate program')
	print(decimal)
	halt

end(start)
