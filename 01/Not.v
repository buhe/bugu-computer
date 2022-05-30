/**
 * Not gate:
 * out = not in
 */
`include "Nand.v"
`default_nettype none

module Not(
	input in,
	output out
);
Nand NAND(.a(in), .b(1'b1), .out(out));
endmodule
