/**
 * 1-bit register:
 * If load[t] == 1 then out[t+1] = in[t]
 *    else out does not change (out[t+1] = out[t])
 */
`include "DFFusr.v"
`default_nettype none
module Bit(
	input wire clk,
	input wire in,
	input wire load,
	output wire out
);

// your implementation comes here:
  
    // Mux(a=muxb, b=in, sel=load, out=muxo);
    // DFF(in=muxo, out=out, out=muxb);
    // reg muxb;
    wire muxo;
    Mux MUX(.a(out),.b(in),.sel(load),.out(muxo));
	DFFusr DFF1(.clk(clk),.in(muxo),.out(out));

endmodule
