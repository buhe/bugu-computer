/** 
 * input clk_in: clock input 100 MHz
 * output clk: clock output 33.333333 MHz
 *
 * Implementation with 2 bit DFF-counter:
 * counter | 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 ....
 * clk     | 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 ....
 */

`default_nettype none

module Clk(
	input wire in,			//external clock 100Mz
	output wire out			//Hack clock 33.333333 MHz
);

// your implementation comes here:



endmodule
