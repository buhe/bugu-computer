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
	output reg out = 1'b0			//Hack clock 33.333333 MHz
);

// your implementation comes here:
parameter NUM_DIV = 5;
reg [15:0] cnt = 16'd0;
// assign out <= 1'b0;

always @(posedge in)
   if(cnt < NUM_DIV) begin
        cnt     <= cnt + 1'b1;
        out    <= out;
    end
    else begin
        cnt     <= 16'd0;
        out    <= ~out;
    end

endmodule
