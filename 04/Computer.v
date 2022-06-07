`default_nettype none
module Computer( 
    input clk_in,				// external clock 100 MHz	
    input btn,			// buttons	(0 if pressed, 1 if released)
	output led			// leds 	(0 off, 1 on)
);
	
    // ROM32K(address=pc ,out=instruction );
    // CPU(inM=Mout ,instruction=instruction ,reset=reset ,outM=outM ,writeM=writeM ,addressM=addressM ,pc=pc );
    // Memory(in=outM ,load=writeM ,address=addressM ,out=Mout );



endmodule
