/**
 * Adds two 16-bit values.
 * The most significant carry bit is ignored.
 * out = a + b (16 bit)
 */

`include "Not.v"
`include "And.v"
`default_nettype none
module And16(
	input wire [15:0] a,
	input wire [15:0] b,
	output wire [15:0] out
);
// your implementation comes here:
    // And(a=a[0], b=b[0], out=out[0]);
    // And(a=a[1], b=b[1], out=out[1]);
    // And(a=a[2], b=b[2], out=out[2]);
    // And(a=a[3], b=b[3], out=out[3]);
    // And(a=a[4], b=b[4], out=out[4]);
    // And(a=a[5], b=b[5], out=out[5]);
    // And(a=a[6], b=b[6], out=out[6]);
    // And(a=a[7], b=b[7], out=out[7]);
    // And(a=a[8], b=b[8], out=out[8]);
    // And(a=a[9], b=b[9], out=out[9]);
    // And(a=a[10], b=b[10], out=out[10]);
    // And(a=a[11], b=b[11], out=out[11]);
    // And(a=a[12], b=b[12], out=out[12]);
    // And(a=a[13], b=b[13], out=out[13]);
    // And(a=a[14], b=b[14], out=out[14]);
    // And(a=a[15], b=b[15], out=out[15]);

    And AND1(.a(a[0]),.b(b[0]),.out(out[0]));
    And AND2(.a(a[1]),.b(b[1]),.out(out[1]));
    And AND3(.a(a[2]),.b(b[2]),.out(out[2]));
    And AND4(.a(a[3]),.b(b[3]),.out(out[3]));
    And AND5(.a(a[4]),.b(b[4]),.out(out[4]));
    And AND6(.a(a[5]),.b(b[5]),.out(out[5]));
    And AND7(.a(a[6]),.b(b[6]),.out(out[6]));
    And AND8(.a(a[7]),.b(b[7]),.out(out[7]));
    And AND9(.a(a[8]),.b(b[8]),.out(out[8]));
    And AND10(.a(a[9]),.b(b[9]),.out(out[9]));
    And AND11(.a(a[10]),.b(b[10]),.out(out[10]));
    And AND12(.a(a[11]),.b(b[11]),.out(out[11]));
    And AND13(.a(a[12]),.b(b[12]),.out(out[12]));
    And AND14(.a(a[13]),.b(b[13]),.out(out[13]));
    And AND15(.a(a[14]),.b(b[14]),.out(out[14]));
    And AND16(.a(a[15]),.b(b[15]),.out(out[15]));

endmodule
