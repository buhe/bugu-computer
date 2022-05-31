/**
 * Demultiplexor:
 * {a, b} = {in, 0} if sel == 0
 *          {0, in} if sel == 1
 */
`include "Not.v"
`include "And.v"
`default_nettype none

module DMux(
	input wire in,
	input wire sel,
    output wire a,
	output wire b
);

// your implementation comes here:
    // Not(in=sel, out=notsel);
    // And(a=in, b=notsel, out=a);
    // And(a=in, b=sel, out=b);
    wire notsel;
    Not NOT2(.in(sel), .out(notsel));
	And AND1(.a(in),.b(notsel),.out(a));
	And AND2(.a(in),.b(sel),.out(b));

endmodule
