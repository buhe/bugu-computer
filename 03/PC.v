/**
 * A 16-bit counter with load control bit.
 * if (load[t] == 1)       out[t+1] = in[t]
 * else if (inc[t] == 1)   out[t+1] = out[t] + 1  (integer addition)
 * else                    out[t+1] = out[t]
 */

`default_nettype none

module PC(
	input wire clk,
	input wire reset,
	input wire [15:0] in,
	input wire load,
	input wire inc,
	output wire [15:0] out
);	 
    // Mux16(a=oldstate, b=op1, sel=inc, out=nextout1);
    // Mux16(a=nextout1, b=in, sel=load, out=nextout2);
    // Mux16(a=nextout2, b=false, sel=reset, out=nextout3);
    // Register(in=nextout3, load=true, out=oldstate, out=out);
    // Inc16(in=oldstate, out=op1);

endmodule
