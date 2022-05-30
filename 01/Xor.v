/** 
* Xor (exclusive or) gate:
* If a<>b out=1 else out=0.
*/
`include "Not.v"
`include "And.v"
`include "Or.v"
`default_nettype none

module Xor(
	input wire a,
	input wire b,
	output wire out
);
	wire nota;		//new wire must be declared
	wire notb;
	Not NOT1(.in(a), .out(nota));	 //NOT1 is instance name
	Not NOT2(.in(b), .out(notb));
	
	wire w1;
	wire w2;
	And AND1(.a(a),.b(notb),.out(w1));
	And AND2(.a(nota),.b(b),.out(w2));

	Or OR(.a(w1),.b(w2),.out(out));
endmodule
