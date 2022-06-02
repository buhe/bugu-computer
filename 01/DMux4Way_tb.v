`include "DMux4Way.v"
`default_nettype none
module DMux4Way_tb();

	integer file;

	reg in = 1'b0;
	reg[1:0] sel = 2'b00;
	wire a = 1'b0;
	wire b = 1'b0;
	wire c = 1'b0;
	wire d = 1'b0;
	
	DMux4Way DMUX4WAY(
	    .in(in),
	    .sel(sel),
	    .a(a),
		.b(b),
		.c(c),
		.d(d)
	  );

	task display;
    	#1 $fwrite(file, "|%1b|%2b|%1b|%1b|%1b|%1b|\n", in,sel,a,b,c,d);
  	endtask
  	
  	initial begin
  		$dumpfile("DMux4Way_tb.vcd");
  		$dumpvars(0, DMux4Way_tb);
		file = $fopen("DMux4Way.out","w");
    	$fwrite(file, "|in|sel|a|b|c|d|\n");
		
        sel = 2'b00;
		display();
        sel = 2'b01;
		display();
  		sel = 2'b10;
		display();
        sel = 2'b11;
		display();
		in = 1'b1;
        sel = 2'b00;
		display();
        sel = 2'b01;
		display();
        sel = 2'b10;
		display();
        sel = 2'b11;
		display();
		$finish();	
	end

endmodule
