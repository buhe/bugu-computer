`include "Bit.v"
module Bit_tb();

	reg clk = 0;
	wire out;
	reg load = 1;
	reg in=1;

	Bit BIT(
    	.clk(clk),
		.load(load),
		.in(in),
		.out(out)
  	);

	always #1 clk = ~clk;


initial begin
  $dumpfile("Bit_tb.vcd");
  $dumpvars(0, Bit_tb);
   # 2 
   # 2 
   # 2 
   # 2 
   $finish;
end

endmodule
