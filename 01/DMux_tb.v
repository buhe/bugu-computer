`include "DMux.v"
`default_nettype none
module DMux_tb();

	integer file;

	reg in = 1'b0;
	reg sel = 1'b0;
	wire a = 1'b0;
	wire b = 1'b0;
	
	DMux DMUX(
	    .in(in),
	    .sel(sel),
	    .a(a),
		.b(b)
	  );

	task display;
    	#1 $fwrite(file, "|%1b|%1b|%1b|%1b|\n", in,sel,a,b);
  	endtask
  	
  	initial begin
  		$dumpfile("DMux_tb.vcd");
  		$dumpvars(0, DMux_tb);
		file = $fopen("DMux.out","w");
    	$fwrite(file, "|in|sel|a|b|\n");
		
        sel = 1'b0;
		display();
        sel = 1'b1;
		display();
  	
		in = 1'b1;
        sel = 1'b0;
		display();
        sel = 1'b1;
		display();
      
		$finish();	
	end

endmodule
