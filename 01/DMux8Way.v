/**
 * 8-way demultiplexor:
 * {a, b, c, d, e, f, g, h} = {in, 0, 0, 0, 0, 0, 0, 0} if sel == 000
 *                            {0, in, 0, 0, 0, 0, 0, 0} if sel == 001
 *                            etc.
 *                            {0, 0, 0, 0, 0, 0, 0, in} if sel == 111
 */

module DMux8Way(
	input wire in,
	input wire [2:0] sel,
    output wire a,
	output wire b,
	output wire c,
	output wire d,
	output wire e,
	output wire f,
	output wire g,
	output wire h
	);

	// your implementation comes here:




endmodule
