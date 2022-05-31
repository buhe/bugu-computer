/** 
 * Multiplexor:
 * out = a if sel == 0
 *       b otherwise
 */
`include "Not.v"
`include "And.v"
`include "Or.v"
`default_nettype none

module Mux(
	input a,
	input b,
	input sel,
	output out
);
    // Not(in=sel, out=notsel);
    // And(a=a, b=notsel, out=outa);
    // And(a=b, b=sel, out=outb);
    // Or(a=outa, b=outb, out=out);

    wire notsel;
    Not NOT(.in(sel), .out(notsel));
	
	wire w1;
	wire w2;
	And AND1(.a(a),.b(notsel),.out(w1));
	And AND2(.a(b),.b(sel),.out(w2));

	Or OR(.a(w1),.b(w2),.out(out));

endmodule
