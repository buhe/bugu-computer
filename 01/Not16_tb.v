`include "Not16.v"
`default_nettype none
module Not16_tb();

	integer file;

	reg[15:0] in = 16'b0000000000000000;
	wire[15:0] out;
	
	Not16 NOT16(
		.in(in),
	    .out(out)
	  );

	task display;
    	#1 $fwrite(file, "|%16b|%16b|\n", in,out);
  	endtask
  	
  	initial begin
  		$dumpfile("Not16_tb.vcd");
  		$dumpvars(0, Not16_tb);
		file = $fopen("Not16.out","w");
    	$fwrite(file, "|in|out|\n");
		
		in=16'b0000000000000000;
		display();
  		
		in=16'b1111111111111111;
		display();

        in=16'b1010101010101010;
		display();
		
		in=16'b0011110011000011;
		display();

        in=16'b0001001000110100;
		display();
		$finish();	
	end

endmodule
