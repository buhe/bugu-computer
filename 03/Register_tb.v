`include "Register.v"
module Register_tb();

	integer file;

	reg clk = 1;
	wire signed [15:0] out;
	reg load = 0;
	reg signed [15:0] in=0;
    reg[9:0] t = 10'b0;

	Register REGISTER(
    	.clk(clk),
		.load(load),
		.in(in),
		.out(out)
  	);

	always #1 clk = ~clk;

    task display;
    	#1 $fwrite(file, "|%4d|%6d|%1b|%6d|\n", t,in,load,out);
  	endtask

initial begin
  $dumpfile("Register_tb.vcd");
  $dumpvars(0, Register_tb);
    	file = $fopen("Register.out","w");
    	$fwrite(file, "|time|in|load|out|\n");
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
