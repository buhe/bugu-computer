`include "DMux8Way.v"
`default_nettype none
module DMux8Way_tb();

	integer file;

	reg in = 1'b0;
	reg[2:0] sel = 3'b000;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
	wire h;
	
	DMux8Way DMUX8WAY(
	    .in(in),
	    .sel(sel),
	    .a(a),
		.b(b),
		.c(c),
		.d(d),
		.e(e),
		.f(f),
		.g(g),
		.h(h)
	  );

	task display;
    	#1 $fwrite(file, "|%1b|%3b|%1b|%1b|%1b|%1b|%1b|%1b|%1b|%1b|\n", in,sel,a,b,c,d,e,f,g,h);
  	endtask
  	
  	initial begin
  		$dumpfile("DMux8Way_tb.vcd");
  		$dumpvars(0, DMux8Way_tb);
		file = $fopen("DMux8Way.out","w");
    	$fwrite(file, "|in|sel|a|b|c|d|e|f|g|h|\n");
		
        sel = 3'b000;
		display();
        sel = 3'b001;
		display();
  		sel = 3'b010;
		display();
        sel = 3'b011;
		display();
		sel = 3'b100;
		display();
        sel = 3'b101;
		display();
  		sel = 3'b110;
		display();
        sel = 3'b111;
		display();
		
		in = 1'b1;
        sel = 3'b000;
		display();
        sel = 3'b001;
		display();
  		sel = 3'b010;
		display();
        sel = 3'b011;
		display();
		sel = 3'b100;
		display();
        sel = 3'b101;
		display();
  		sel = 3'b110;
		display();
        sel = 3'b111;
		display();
		$finish();	
	end

endmodule
