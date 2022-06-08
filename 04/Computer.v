`default_nettype none
`include "Mux16.v"
`include "DMux.v"
`include "Btn.v"
`include "Led.v"

`include "Not.v"
`include "And.v"
`include "Or.v"
`include "RAM.v"
`include "Register.v"
`include "ALUusr.v"
`include "PC.v"
`include "Not16.v"
`include "And16.v"
`include "Add16.v"
`include "Or8Way.v"

`include "Memory.v"
`include "CPU.v"
`include "ROM.v"
module Computer( 
    input clk_in,				// external clock 100 MHz	
    input btn,			// buttons	(0 if pressed, 1 if released)
	output led,			// leds 	(0 off, 1 on)
    input reset
);
	
    // ROM32K(address=pc ,out=instruction );
    // CPU(inM=Mout ,instruction=instruction ,reset=reset ,outM=outM ,writeM=writeM ,addressM=addressM ,pc=pc );
    // Memory(in=outM ,load=writeM ,address=addressM ,out=Mout );

    wire [15:0] addressM;
    wire [15:0] outM;
    wire [15:0] instruction;
    wire [15:0] pc;
    wire [15:0] Mout;

    wire writeM;

	ROM ROM(
		.instruction(instruction),
		.pc(pc)
	);
	CPU CPU(
		.clk(clk_in),
		.inM(Mout),
		.instruction(instruction),
		.reset(reset),
		.outM(outM),
		.writeM(writeM),
		.addressM(addressM),
		.pc(pc)
	);

	Memory MEMORY(
		.clk(clk_in),
		.address(addressM),
		.in(outM),
		.out(Mout),
		.load(writeM),
        .btn(btn),
        .led(led)
	);

endmodule
