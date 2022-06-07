`include "CPU.v"
`default_nettype none
module CPU_tb();

	integer file;
	reg clk = 1;	
	reg [15:0] inM=0;
	reg [15:0] instruction=0;
	reg reset=0;
	wire signed [15:0] outM;
	wire writeM;
	wire [15:0] addressM;
	wire [15:0] pc;
    reg[9:0] t = 10'b0;

	CPU CPU(
		.clk(clk),
		.inM(inM),
		.instruction(instruction),
		.reset(reset),
		.outM(outM),
		.writeM(writeM),
		.addressM(addressM),
		.pc(pc)
	);

	 
	always #1 clk = ~clk;

	task display;
    	#1 $fwrite(file, "|%6d|%6d|%16b|  %1b  |%6d|  %1b   |%6d|%6d|\n",t,inM,instruction,reset,outM,writeM,addressM[14:0],pc);
  	endtask
  	
  	initial begin
  		$dumpfile("CPU_tb.vcd");
  		$dumpvars(0, CPU_tb);
		file = $fopen("CPU.out","w");
    	$fwrite(file, "| time |  inM |  instruction   |reset| outM |writeM|addres|  pc  |\n");
		

instruction = 16'b0011000000111001; // @12345
display();
t=1;display();

instruction = 16'b1110110000010000; // D=A
display();
t=2;display();

instruction = 16'b0101101110100000; // @23456
display();
t=3;display();

instruction = 16'b1110000111110000; // AD=A-D
inM = 11111;
display();
t=4;display();

instruction = 16'b0000001111101011; // @1003
display();
t=5;display();

instruction = 16'b1110001100001000; // M=D
display();
t=6;display();

instruction = 16'b0000001111101100; // @1004
display();
t=7;display();

instruction = 16'b1110001110011000; // MD=D-1
display();
t=8;display();

instruction = 16'b0000001111101000; // @1000
display();
t=9;display();

instruction = 16'b1111010011110000; // AD=D-M
display();
t=10;display();

instruction = 16'b0000000000001110; // @14
display();
t=11;display();

instruction = 16'b1110001100000100; // D;jlt
display();
t=12;display();

instruction = 16'b0000001111100111; // @999
display();
t=13;display();

instruction = 16'b1111110111100000; // A=M+1
display();
t=14;display();

instruction = 16'b1110001100101000; // AM=D
display();
t=15;display();

instruction = 16'b0000000000010101; // @21
display();
t=16;display();

instruction = 16'b1110011111000010; // D+1;jeq
display();
t=17;display();

instruction = 16'b0000000000000010; // @2
display();
t=18;display();

instruction = 16'b1110000010111000; // AMD=D+A
display();
t=19;display();

// #2 instruction = 16'b0000001111101000; // @1000
// display();

// #2 instruction = 16'b1110111010010000; // D=-1
// display();

// #2 instruction = 16'b1110001100000001; // D;JGT
// display();

// #2 instruction = 16'b1110001100000010; // D;JEQ
// display();

// #2 instruction = 16'b1110001100000011; // D;JGE
// display();

// #2 instruction = 16'b1110001100000100; // D;JLT
// display();

// #2 instruction = 16'b1110001100000101; // D;JNE
// display();

// #2 instruction = 16'b1110001100000110; // D;JLE
// display();

// #2 instruction = 16'b1110001100000111; // D;JMP
// display();

// #2 instruction = 16'b1110101010010000; // D=0
// display();

// #2 instruction = 16'b1110001100000001; // D;JGT
// display();

// #2 instruction = 16'b1110001100000010; // D;JEQ
// display();

// #2 instruction = 16'b1110001100000011; // D;JGE
// display();

// #2 instruction = 16'b1110001100000100; // D;JLT
// display();

// #2 instruction = 16'b1110001100000101; // D;JNE
// display();

// #2 instruction = 16'b1110001100000110; // D;JLE
// display();

// #2 instruction = 16'b1110001100000111; // D;JMP
// display();

// #2 instruction = 16'b1110111111010000; // D=1
// display();

// #2 instruction = 16'b1110001100000001; // D;JGT
// display();

// #2 instruction = 16'b1110001100000010; // D;JEQ
// display();

// #2 instruction = 16'b1110001100000011; // D;JGE
// display();

// #2 instruction = 16'b1110001100000100; // D;JLT
// display();

// #2 instruction = 16'b1110001100000101; // D;JNE
// display();

// #2 instruction = 16'b1110001100000110; // D;JLE
// display();

// #2 instruction = 16'b1110001100000111; // D;JMP
// display();

// #2 reset=1;
// display();

// #2 instruction = 16'b0111111111111111; // @32767
// #2 reset=0;
// display();


$finish;
end
endmodule
