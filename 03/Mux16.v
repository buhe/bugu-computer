/**
 * 16-bit multiplexor: 
 * for i = 0..15 out[i] = a[i] if sel == 0 
 *                        b[i] if sel == 1
 */
`default_nettype none

module Mux16(
	input [15:0] a,
	input [15:0] b,
   	input sel,
	output [15:0] out
);
// your implementation comes here:

    // Mux(a=a[0], b=b[0], sel=sel, out=out[0]);
	// Mux(a=a[1], b=b[1], sel=sel, out=out[1]);
	// Mux(a=a[2], b=b[2], sel=sel, out=out[2]);
	// Mux(a=a[3], b=b[3], sel=sel, out=out[3]);
	// Mux(a=a[4], b=b[4], sel=sel, out=out[4]);
	// Mux(a=a[5], b=b[5], sel=sel, out=out[5]);
	// Mux(a=a[6], b=b[6], sel=sel, out=out[6]);
	// Mux(a=a[7], b=b[7], sel=sel, out=out[7]);
	// Mux(a=a[8], b=b[8], sel=sel, out=out[8]);
	// Mux(a=a[9], b=b[9], sel=sel, out=out[9]);
	// Mux(a=a[10], b=b[10], sel=sel, out=out[10]);
	// Mux(a=a[11], b=b[11], sel=sel, out=out[11]);
	// Mux(a=a[12], b=b[12], sel=sel, out=out[12]);
	// Mux(a=a[13], b=b[13], sel=sel, out=out[13]);
	// Mux(a=a[14], b=b[14], sel=sel, out=out[14]);
	// Mux(a=a[15], b=b[15], sel=sel, out=out[15]);
    	Mux MUX1(.a(a[0]),.b(b[0]),.sel(sel),.out(out[0]));
    	Mux MUX2(.a(a[1]),.b(b[1]),.sel(sel),.out(out[1]));
    	Mux MUX3(.a(a[2]),.b(b[2]),.sel(sel),.out(out[2]));
    	Mux MUX4(.a(a[3]),.b(b[3]),.sel(sel),.out(out[3]));
    	Mux MUX5(.a(a[4]),.b(b[4]),.sel(sel),.out(out[4]));
    	Mux MUX6(.a(a[5]),.b(b[5]),.sel(sel),.out(out[5]));
    	Mux MUX7(.a(a[6]),.b(b[6]),.sel(sel),.out(out[6]));
    	Mux MUX8(.a(a[7]),.b(b[7]),.sel(sel),.out(out[7]));
    	Mux MUX9(.a(a[8]),.b(b[8]),.sel(sel),.out(out[8]));
    	Mux MUX10(.a(a[9]),.b(b[9]),.sel(sel),.out(out[9]));
    	Mux MUX11(.a(a[10]),.b(b[10]),.sel(sel),.out(out[10]));
    	Mux MUX12(.a(a[11]),.b(b[11]),.sel(sel),.out(out[11]));
    	Mux MUX13(.a(a[12]),.b(b[12]),.sel(sel),.out(out[12]));
    	Mux MUX14(.a(a[13]),.b(b[13]),.sel(sel),.out(out[13]));
    	Mux MUX15(.a(a[14]),.b(b[14]),.sel(sel),.out(out[14]));
    	Mux MUX16(.a(a[15]),.b(b[15]),.sel(sel),.out(out[15]));

endmodule
