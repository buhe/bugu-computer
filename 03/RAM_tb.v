`include "RAM.v"
module RAM_tb();

	integer file;

	reg clk = 1;
	wire signed [15:0] out;
	reg signed [15:0] address=0;
	reg load = 0;
	reg signed [15:0] in=0;
    reg[9:0] t = 10'b0;

	RAM RAM1(
    	.clk(clk),
		.address(address),
		.load(load),
		.in(in),
		.out(out)
  	);

	always #1 clk = ~clk;

    task display;
    	#1 $fwrite(file, "|%4d|%6d|%1b|%6d|%6d|\n", t,in,load,address,out);
  	endtask

initial begin
  $dumpfile("RAM_tb.vcd");
  $dumpvars(0, RAM_tb);
    	file = $fopen("RAM.out","w");
    	$fwrite(file, "|time|in|load|address|out|\n");
        display();

        t=1;display();

        load=1;display();

        t=2;display();

        in=4321;load=0;display();

        t=3;display();

        address=4321;load=1;display();

        t=4;display();

        address=0;load=0;display();

        t=5;display();

        in=12345;address=12345;display();
   $finish;
end

endmodule
