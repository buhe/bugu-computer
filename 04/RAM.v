/**
* tangnano4k not support block ram https://github.com/YosysHQ/yosys/wiki/FPGA-family-feature-matrix
* out = M[address] (continuosly assigned using combinatorial logic)
* if (load =i= 1) M[address][t+1] = in[t] (clocked using sequential logic)
*/

`default_nettype none
module RAM(
	input wire clk,
	input wire [15:0] address,
	input wire [15:0] in,
	input wire load,
	output wire [15:0] out
);
	
	reg [15:0] regRAM [0:10]; 
	always @(negedge clk)
		if (load) regRAM[address[3:0]] <= in;

	assign out = regRAM[address[3:0]];
endmodule
