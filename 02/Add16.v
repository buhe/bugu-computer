/**
 * Adds two 16-bit values.
 * The most significant carry bit is ignored.
 * out = a + b (16 bit)
 */
`include "FullAdder.v"
`default_nettype none
module Add16(
	input wire [15:0] a,
	input wire [15:0] b,
	output wire [15:0] out
);
// your implementation comes here:
//    HalfAdder(a=a[0], b=b[0], sum=out[0], carry=carry);
//     FullAdder(a=a[1], b=b[1], c=carry, sum=out[1], carry=carry1);
//     FullAdder(a=a[2], b=b[2], c=carry1, sum=out[2], carry=carry2);
//     FullAdder(a=a[3], b=b[3], c=carry2, sum=out[3], carry=carry3);
//     FullAdder(a=a[4], b=b[4], c=carry3, sum=out[4], carry=carry4);
//     FullAdder(a=a[5], b=b[5], c=carry4, sum=out[5], carry=carry5);
//     FullAdder(a=a[6], b=b[6], c=carry5, sum=out[6], carry=carry6);
//     FullAdder(a=a[7], b=b[7], c=carry6, sum=out[7], carry=carry7);
//     FullAdder(a=a[8], b=b[8], c=carry7, sum=out[8], carry=carry8);
//     FullAdder(a=a[9], b=b[9], c=carry8, sum=out[9], carry=carry9);
//     FullAdder(a=a[10], b=b[10], c=carry9, sum=out[10], carry=carry10);
//     FullAdder(a=a[11], b=b[11], c=carry10, sum=out[11], carry=carry11);
//     FullAdder(a=a[12], b=b[12], c=carry11, sum=out[12], carry=carry12);
//     FullAdder(a=a[13], b=b[13], c=carry12, sum=out[13], carry=carry13);
//     FullAdder(a=a[14], b=b[14], c=carry13, sum=out[14], carry=carry14);
//     FullAdder(a=a[15], b=b[15], c=carry14, sum=out[15], carry=carry15);

    wire carry;
    wire carry1;
    wire carry2;
    wire carry3;
    wire carry4;
    wire carry5;
    wire carry6;
    wire carry7;
    wire carry8;
    wire carry9;
    wire carry10;
    wire carry11;
    wire carry12;
    wire carry13;
    wire carry14;
    wire carry15;
    HalfAdder HalfAdder1(.a(a[0]),.b(b[0]),.sum(out[0]),.carry(carry));
    FullAdder FullAdder1(.a(a[1]),.b(b[1]),.c(carry),.sum(out[1]),.carry(carry1));
    FullAdder FullAdder2(.a(a[2]),.b(b[2]),.c(carry1),.sum(out[2]),.carry(carry2));
    FullAdder FullAdder3(.a(a[3]),.b(b[3]),.c(carry2),.sum(out[3]),.carry(carry3));
    FullAdder FullAdder4(.a(a[4]),.b(b[4]),.c(carry3),.sum(out[4]),.carry(carry4));
    FullAdder FullAdder5(.a(a[5]),.b(b[5]),.c(carry4),.sum(out[5]),.carry(carry5));
    FullAdder FullAdder6(.a(a[6]),.b(b[6]),.c(carry5),.sum(out[6]),.carry(carry6));
    FullAdder FullAdder7(.a(a[7]),.b(b[7]),.c(carry6),.sum(out[7]),.carry(carry7));
    FullAdder FullAdder8(.a(a[8]),.b(b[8]),.c(carry7),.sum(out[8]),.carry(carry8));
    FullAdder FullAdder9(.a(a[9]),.b(b[9]),.c(carry8),.sum(out[9]),.carry(carry9));
    FullAdder FullAdder10(.a(a[10]),.b(b[10]),.c(carry9),.sum(out[10]),.carry(carry10));
    FullAdder FullAdder11(.a(a[11]),.b(b[11]),.c(carry10),.sum(out[11]),.carry(carry11));
    FullAdder FullAdder12(.a(a[12]),.b(b[12]),.c(carry11),.sum(out[12]),.carry(carry12));
    FullAdder FullAdder13(.a(a[13]),.b(b[13]),.c(carry12),.sum(out[13]),.carry(carry13));
    FullAdder FullAdder14(.a(a[14]),.b(b[14]),.c(carry13),.sum(out[14]),.carry(carry14));
    FullAdder FullAdder15(.a(a[15]),.b(b[15]),.c(carry14),.sum(out[15]),.carry(carry15));

endmodule
