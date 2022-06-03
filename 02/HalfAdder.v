/**
 * Computes the sum of two bits.
 */
`include "Xor.v"
`default_nettype none
module HalfAdder(
	input wire a,		//1-bit input
	input wire b,		//1-bit inpur
	output wire sum,	//Right bit of a + b
	output wire carry	//Lef bit of a + b
);

// your implementation comes here:
    // Xor(a=a, b=b, out=sum);
    // And(a=a, b=b, out=carry);



endmodule
