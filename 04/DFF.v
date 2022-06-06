/**
* Data-Flip-Flop
* out[t+1] = in[t]
*
* This module is implemented using reg-variables in verilog
*/

`default_nettype none
module DFFusr(
		input wire clk,
		input wire in,
		output reg out
);
	always @(negedge clk)
		if (in) out <= 1'b1;
		else out <= 1'b0;

endmodule

