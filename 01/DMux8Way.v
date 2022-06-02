/**
 * 8-way demultiplexor:
 * {a, b, c, d, e, f, g, h} = {in, 0, 0, 0, 0, 0, 0, 0} if sel == 000
 *                            {0, in, 0, 0, 0, 0, 0, 0} if sel == 001
 *                            etc.
 *                            {0, 0, 0, 0, 0, 0, 0, in} if sel == 111
 */
 `include "DMux4Way.v"
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
    //   DMux(in=in, sel=sel[2], a=abcd, b=efgh);
    // DMux4Way(in=abcd, sel=sel[0..1], a=a, b=b, c=c, d=d);
    // DMux4Way(in=efgh, sel=sel[0..1], a=e, b=f, c=g, d=h);
    wire abcd;
    wire efgh;
    DMux DMUX1(.in(in), .sel(sel[2]), .a(abcd), .b(efgh));
    DMux4Way DMUX2(.in(abcd), .sel(sel[1:0]), .a(a), .b(b),.c(c), .d(d));
    DMux4Way DMUX3(.in(efgh), .sel(sel[1:0]), .a(e), .b(f),.c(g), .d(h));


endmodule
