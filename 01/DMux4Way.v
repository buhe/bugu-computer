/**
 * 4-way demultiplexor:
 * {a, b, c, d} = {in, 0, 0, 0} if sel == 00
 *                {0, in, 0, 0} if sel == 01
 *                {0, 0, in, 0} if sel == 10
 *                {0, 0, 0, in} if sel == 11
 */
 `include "DMux.v"
module DMux4Way(
	input wire in,
	input wire [1:0] sel,
    output wire a,
	output wire b,
	output wire c,
	output wire d
	);
// your implementation comes here:
    // DMux(in=in, sel=sel[1], a=ab, b=cd);
    // DMux(in=ab, sel=sel[0], a=a, b=b);
    // DMux(in=cd, sel=sel[0], a=c, b=d);
    wire ab;
    wire cd;
    DMux DMUX1(.in(in), .sel(sel[1]), .a(ab), .b(cd));
    DMux DMUX2(.in(ab), .sel(sel[0]), .a(a), .b(b));
    DMux DMUX3(.in(cd), .sel(sel[0]), .a(c), .b(d));


endmodule
