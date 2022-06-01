`include "And16.v"
`default_nettype none
module And16_tb();

	integer file;

	reg a = 16'b0000000000000000;
	reg b = 16'b0000000000000000;
	wire out;
	
	And16 AND16(
	    .a(a),
		.b(b),
	    .out(out)
	  );

	task display;
    	#1 $fwrite(file, "|%16b|%16b|%16b|\n", a,b,out);
  	endtask
  	
  	initial begin
  		$dumpfile("And16_tb.vcd");
  		$dumpvars(0, And16_tb);
		file = $fopen("And16.out","w");
    	$fwrite(file, "|a|b|out|\n");
		
		a=0;b=0;sel=0;
		display();

        a=0;b=0;sel=1;
		display();
  		
		a=0;b=1;sel=0;
		display();

        a=0;b=1;sel=1;
		display();
		
		a=1;b=0;sel=0;
		display();

        a=1;b=0;sel=1;
		display();
		
		a=1;b=1;sel=0;
		display();

        a=1;b=1;sel=1;
		display();
		$finish();	
	end

endmodule
