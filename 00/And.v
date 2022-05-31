/**
 * And gate: 
 * out = 1 if (a == 1 and b == 1)
 *       0 otherwise
 */

`default_nettype none

module And(
	input a,
	input b,
	output out
);
    wire notaandb;

// your implementation comes here:
    Nand NAND(.a(a), .b(b), .out(notaandb));
    Not NOT(.in(notaandb), .out(out));


endmodule
