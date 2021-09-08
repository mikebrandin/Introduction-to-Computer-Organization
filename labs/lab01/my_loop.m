	comment(` Mike Brandin CPSC-2311 Lab Section 2')
	comment(` initialize variables')
	word(sum,0)
	word(i,0)
	word(zero,0)
	word(one,1)
	word(ten,10)

label(start)
	comment(` set value of sum to 0 and i to 1')
	load(zero)
	store(sum)
	load(one)
	store(i)

comment(` begin for loop')
label(loop)

comment(` check if i is greater than 10, if true: branch to the done label')
	load(i)
	sub(ten)
	bgt0(done)
	add(ten)

comment(` if check was false: perform sum = sum + i')
	load(sum)
	add(i)
	store(sum)

comment(` increment i: i = i + 1')
	load(i)
	add(one)
	store(i)

comment(` branch advance to loop label to continue looping')
	ba(loop)

label(done)

comment(` print the sum out')
	print(sum)
	halt

end(start)
