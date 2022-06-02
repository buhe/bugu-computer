/**
 * 16-bit Not:
 * for i=0..15: out[i] = not in[i]
 */
`include "Not.v"
`default_nettype none

module Not16(
	input [15:0] in,
	output [15:0] out
);

//   Not(in=in[0], out=out[0]);
// 	Not(in=in[1], out=out[1]);
// 	Not(in=in[2], out=out[2]);
// 	Not(in=in[3], out=out[3]);
// 	Not(in=in[4], out=out[4]);
// 	Not(in=in[5], out=out[5]);
// 	Not(in=in[6], out=out[6]);
// 	Not(in=in[7], out=out[7]);
// 	Not(in=in[8], out=out[8]);
// 	Not(in=in[9], out=out[9]);
// 	Not(in=in[10], out=out[10]);
// 	Not(in=in[11], out=out[11]);
// 	Not(in=in[12], out=out[12]);
// 	Not(in=in[13], out=out[13]);
// 	Not(in=in[14], out=out[14]);
// 	Not(in=in[15], out=out[15]);

Not NOT1(.in(in[0]), .out(out[0]));
Not NOT2(.in(in[1]), .out(out[1]));
Not NOT3(.in(in[2]), .out(out[2]));
Not NOT4(.in(in[3]), .out(out[3]));
Not NOT5(.in(in[4]), .out(out[4]));
Not NOT6(.in(in[5]), .out(out[5]));
Not NOT7(.in(in[6]), .out(out[6]));
Not NOT8(.in(in[7]), .out(out[7]));
Not NOT9(.in(in[8]), .out(out[8]));
Not NOT10(.in(in[9]), .out(out[9]));
Not NOT11(.in(in[10]), .out(out[10]));
Not NOT12(.in(in[11]), .out(out[11]));
Not NOT13(.in(in[12]), .out(out[12]));
Not NOT14(.in(in[13]), .out(out[13]));
Not NOT15(.in(in[14]), .out(out[14]));
Not NOT16(.in(in[15]), .out(out[15]));
endmodule
