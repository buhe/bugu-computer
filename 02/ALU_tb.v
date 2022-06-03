`include "ALU.v"
`default_nettype none
module ALU_tb();

	integer file;

	reg[15:0] x = 16'b0000000000000000;
	reg[15:0] y = 16'b0000000000000000;
    reg zx = 0;
    reg nx = 0;
    reg zy = 0;
    reg ny = 0;
    reg f = 0;
    reg no = 0;

	wire[15:0] out;
    wire zr;
    wire ng;
	
	ALU ALU(
	    .x(x),
		.y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
	    .out(out),
	    .zr(zr),
	    .ng(ng)
	  );

	task display;
    	#1 $fwrite(file, "|%16b|%16b|%1b|%1b|%1b|%1b|%1b|%1b|%16b|%1b|%1b|\n", x,y,zx,nx,zy,ny,f,no,out,zr,ng);
  	endtask
  	
  	initial begin
  		$dumpfile("ALU_tb.vcd");
  		$dumpvars(0, ALU_tb);
		file = $fopen("ALU.out","w");
    	$fwrite(file, "|x|y|zx|nx|zy|ny|f|no|out|zr|ng|\n");
		
		a=16'b0000000000000000;b=16'b0000000000000000;
		display();

        a=16'b0000000000000000;b=16'b1111111111111111;
		display();
  		
		a=16'b1111111111111111;b=16'b1111111111111111;
		display();

        a=16'b1010101010101010;b=16'b0101010101010101;
		display();
		
		a=16'b0011110011000011;b=16'b0000111111110000;
		display();

        a=16'b0001001000110100;b=16'b1001100001110110;
		display();
		$finish();	
	end

endmodule
