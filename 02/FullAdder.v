/**
 * Computes the sum of three bits.
 */
`default_nettype none

module FullAdder(
	input wire a,		//1-bit input
	input wire b,		//1-bit input
	input wire c,		//1-bit input
	output wire sum,	//Right bit of a + b + c
	output wire carry	//Left bit of a + b + c
);
// your implementation comes here:

    // HalfAdder(a=a, b=b, sum=hsum, carry=hcarry);
    // HalfAdder(a=c, b=hsum, sum=sum, carry=hcarry2);
    // Or(a=hcarry, b=hcarry2, out=carry);


endmodule
