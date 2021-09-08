//Mike Brandin CPSC 2310 Lab 5

public class FullAdder
{
	int sum;
	int carry;

	FullAdder()
	{
		sum = 0;
		carry = 0;
	}

	public int evaluate(int A, int B, int carryIn)
	{
		//reset sum and carry values for new calculation
		sum = carry = 0;
		//if All 3 or 1 flags are set sum = 1
		if ((A==1 && B==1 && carryIn==1) || ((A==0 && B==0) && carryIn==1) || ((A==1 && B==0) && carryIn==0) || ((A==0 && B==1) && carryIn==0))
			sum = 1;

		//if all 3 or 2 flags are set carry = 1
		if ((A==1 && B==1 && carryIn==1) || (A==1 && B==1 && carryIn==0) || (A==0 && B==1 && carryIn==1) || (A==1 && B==0 && carryIn==1))
			carry = 1;

		//return the sum
		return sum;
	}

	public int getCarry()
	{
		return carry;
	}

	public static void main(String args[])
	{
		FullAdder testAdder = new FullAdder();

		System.out.println("Testing FullAdder Class");
		System.out.print("evaluate(0, 0, 0) returns " +
		testAdder.evaluate(0, 0, 0) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 0 with carry: 0 \n");

		System.out.print("evaluate(0, 0, 1) returns " +
		testAdder.evaluate(0, 0, 1) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 1 with carry: 0 \n");

		System.out.print("evaluate(0, 1, 0) returns " +
		testAdder.evaluate(0, 1, 0) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 1 with carry: 0 \n");

		System.out.print("evaluate(0, 1, 1) returns " +
		testAdder.evaluate(0, 1, 1) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 0 with carry: 1 \n");

		System.out.print("evaluate(1, 0, 0) returns " +
		testAdder.evaluate(1, 0, 0) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 1 with carry: 0 \n");

		System.out.print("evaluate(1, 0, 1) returns " +
		testAdder.evaluate(1, 0, 1) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 0 with carry: 1 \n");

		System.out.print("evaluate(1, 1, 0) returns " +
		testAdder.evaluate(1, 1, 0) );
		System.out.println(" with carry: " + testAdder.getCarry() );
		System.out.println("        " +
		" Answer should be 0 with carry: 1 \n");

		System.out.print("evaluate(1, 1, 1) returns " +
		testAdder.evaluate(1, 1, 1) );
		System.out.println(" with carry: " + testAdder.getCarry());
		System.out.println("        " +
		" Answer should be 1 with carry: 1 \n");

		System.out.println("Done Testing FullAdder Class");
	}
}
