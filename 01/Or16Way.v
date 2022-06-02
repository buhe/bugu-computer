/**
 * 16-way Or: 
 * out = (in[0] or in[1] or ... or in[15])
 */
`default_nettype none
`include "Or.v"
`include "Not.v"
module Or16Way(
	input [15:0] in,
	output out
);
    // Or(a = in[0], b = in[1], out = o1);
    // Or(a = o1, b = in[2], out = o2);
    // Or(a = o2, b = in[3], out = o3);
    // Or(a = o3, b = in[4], out = o4);
    // Or(a = o4, b = in[5], out = o5);
    // Or(a = o5, b = in[6], out = o6);
    // Or(a = o6, b = in[7], out = o7);
    // Or(a = o7, b = in[8], out = o8);
    // Or(a = o8, b = in[9], out = o9);
    // Or(a = o9, b = in[10], out = o10);
    // Or(a = o10, b = in[11], out = o11);
    // Or(a = o11, b = in[12], out = o12);
    // Or(a = o12, b = in[13], out = o13);
    // Or(a = o13, b = in[14], out = o14);
    // Or(a = o14, b = in[15], out = out);



endmodule
