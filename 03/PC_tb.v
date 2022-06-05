`include "PC.v"
module PC_tb();

	integer file;

	reg clk = 1;
	wire signed [15:0] out;
	reg reset = 0;
	reg load = 0;
	reg inc = 0;
	reg signed [15:0] in=0;
    reg[9:0] t = 10'b0;

	PC PC1(
    	.clk(clk),
		.reset(reset),
		.load(load),
		.inc(inc),
		.in(in),
		.out(out)
  	);

	always #1 clk = ~clk;

    task display;
    	#1 $fwrite(file, "|%4d|%6d|%1b|%1b|%1b|%6d|\n", t,in,reset,load,inc,out);
  	endtask

initial begin
  $dumpfile("PC_tb.vcd");
  $dumpvars(0, PC_tb);
    	file = $fopen("PC.out","w");
    	$fwrite(file, "|time|in|reset|load|inc|out|\n");
        display();

        t=1;display();

        in=0;load=1;display();

        t=2;display();

        in=-32123;load=0;display();

        t=3;display();

        in=11111;load=0;display();

        t=4;display();

        in=-32123;load=1;display();

        t=5;display();

        in=-32123;load=1;display();
   $finish;
end

endmodule
