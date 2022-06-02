/**
 * 8-way Or: 
 * out = (in[0] or in[1] or ... or in[7])
 */
`include "Or.v"
`include "Not.v"
`default_nettype none

module Or8Way(
	input [7:0] in,
	output out
);

    // Or(a=in[0], b=in[1], out=temp01);
    // Or(a=temp01, b=in[2], out=temp012);
    // Or(a=temp012, b=in[3], out=temp0123);
    // Or(a=temp0123, b=in[4], out=temp01234);
    // Or(a=temp01234, b=in[5], out=temp012345);
    // Or(a=temp012345, b=in[6], out=temp0123456);
    // Or(a=temp0123456, b=in[7], out=out);

endmodule
