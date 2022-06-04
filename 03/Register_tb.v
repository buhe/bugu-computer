`include "Register.v"
module Register_tb();

	integer file;

	reg clk = 1;
	wire out;
	reg load = 0;
	reg in=0;
    reg[9:0] t = 10'b0;

	Bit BIT(
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
  $dumpvars(0, Regester_tb);
    	file = $fopen("Register.out","w");
    	$fwrite(file, "|time|in|load|out|\n");
        display();

        t=1;display();

        in=0;load=1;display();

        t=2;display();

        in=1;load=0;display();

        t=3;display();

        in=1;load=1;display();

        t=4;display();

        in=0;load=0;display();

        t=5;display();

        in=1;load=0;display();
   $finish;
end

endmodule
