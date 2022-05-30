 /**
 * Or gate:
 * out = 1 if (a == 1 or b == 1)
 *       0 otherwise
 */
`default_nettype none
 `include "Not.v"
module Or(
	input a,
	input b,
	output out
);
    wire nota;
    wire notb;
    Not NOT1(.in(a), .out(nota));
    Not NOT2(.in(b), .out(notb));
    Nand NAND(.a(nota), .b(notb), .out(out));


endmodule
