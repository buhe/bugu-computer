/**
 * The Hack CPU (Central Processing unit), consisting of an ALU,
 * two registers named A and D, and a program counter named PC.
 * The CPU is designed to fetch and execute instructions written in 
 * the Hack machine language. In particular, functions as follows:
 * Executes the inputted instruction according to the Hack machine 
 * language specification. The D and A in the language specification
 * refer to CPU-resident registers, while M refers to the external
 * memory location addressed by A, i.e. to Memory[A]. The inM input 
 * holds the value of this location. If the current instruction needs 
 * to write a value to M, the value is placed in outM, the address 
 * of the target location is placed in the addressM output, and the 
 * writeM control bit is asserted. (When writeM==0, any value may 
 * appear in outM). The outM and writeM outputs are combinational: 
 * they are affected instantaneously by the execution of the current 
 * instruction. The addressM and pc outputs are clocked: although they 
 * are affected by the execution of the current instruction, they commit 
 * to their new values only in the next time step. If reset==1 then the 
 * CPU jumps to address 0 (i.e. pc is set to 0 in next time step) rather 
 * than to the address resulting from executing the current instruction. 
 */

`default_nettype none
module CPU(
		input clk,
    	input [15:0] inM,         	// M value input  (M = contents of RAM[A])
    	input [15:0] instruction, 	// Instruction for execution
		input reset,           	// Signals whether to re-start the current
                         				// program (reset==1) or continue executing
                         				// the current program (reset==0).

    	output [15:0] outM,        // M value output
    	output writeM,          	// Write to M? 
    	output [15:0] addressM,    // Address in data memory (of M) to read
    	output [15:0] pc         	// address of next instruction
);

// your implementation comes here:

    // And(a=instruction[15] ,b=instruction[5] ,out=d1 ); A
    // And(a=instruction[15] ,b=instruction[4] ,out=d2 ); D
    // And(a=instruction[15] ,b=instruction[3] ,out=d3,out=writeM ); M
    // And(a=instruction[15] ,b=instruction[2] ,out=j1 );
    // And(a=instruction[15] ,b=instruction[1] ,out=j2 );
    // And(a=instruction[15] ,b=instruction[0] ,out=j3 );

    // //A Register
    // Mux16(a=instruction ,b=outputM ,sel=instruction[15] ,out=Ainput );
    // Not(in=instruction[15],out=Aload1);
    // Or(a=d1,b=Aload1,out=Aload);
    // ARegister(in=Ainput ,load=Aload ,out=Areg, out[0..14]= addressM );

    // //D Register
    // DRegister(in=outputM ,load=d2 ,out=Dreg );

    // //ALU
    // Mux16(a=Areg,b=inM,sel=instruction[12],out=y); when a == 1 opr M else opr A
    // ALU(x=Dreg ,y=y ,zx=instruction[11] ,nx=instruction[10] ,zy=instruction[9] ,ny=instruction[8] ,f=instruction[7] ,no=instruction[6] ,out=outputM ,out=outM,zr=zr ,ng=ng );

    // //PC
    // And(a=ng,b=j1,out=tmp1); < 0
    // And(a=zr,b=j2,out=tmp2); == 0
    // Not(in=zr,out=notzr);
    // Not(in=ng,out=notng);
    // And(a=notzr,b=notng,out=ps); > 0
    // And(a=ps,b=j3,out=tmp3);
    // Or(a=tmp1,b=tmp2,out=tmp);
    // Or(a=tmp,b=tmp3,out=jump); when != 000 jump
    // Not(in=jump,out=inc);
    // PC(in=Areg ,load=jump ,inc=inc ,reset=reset ,out[0..14]=pc );

    wire d1;
    wire d2;
    wire d3;
    wire j1;
    wire j2;
    wire j3;
    And AND1(.a(instruction[15]),.b(instruction[5]),.out(d1));
    And AND2(.a(instruction[15]),.b(instruction[4]),.out(d2));
    And AND3(.a(instruction[15]),.b(instruction[3]),.out(d3));
    assign writeM = d3;
    And AND4(.a(instruction[15]),.b(instruction[2]),.out(j1));
    And AND5(.a(instruction[15]),.b(instruction[1]),.out(j2));
    And AND6(.a(instruction[15]),.b(instruction[0]),.out(j3));

    // A reg
    wire[15:0] outputM;
    wire[15:0] Ainput;
    wire Aload1;
    wire Aload;
    wire[15:0] Areg;
    Mux16 MUX16a(.a(instruction),.b(outputM),.sel(instruction[15]),.out(Ainput));
    Not NOT1(.in(instruction[15]), .out(Aload1));
    Or OR1(.a(Aload1),.b(d1),.out(Aload));
    Register REGISTERa(.in(Ainput),.load(Aload),.out(Areg), .clk(clk));
    assign addressM = Areg;

    // D reg
    wire[15:0] Dreg;
    Register REGISTER1d(.in(outputM),.load(d2),.out(Dreg), .clk(clk));

    // ALU
    wire[15:0] y;
    wire zr;
    wire ng;
    Mux16 MUX16alu(.a(Areg),.b(inM),.sel(instruction[12]),.out(y));
    ALU ALU(
	    .x(Dreg),
		.y(y),
        .zx(instruction[11]),
        .nx(instruction[10]),
        .zy(instruction[9]),
        .ny(instruction[8]),
        .f(instruction[7]),
        .no(instruction[6]),
	    .out(outputM),
	    .zr(zr),
	    .ng(ng)
	  );
      assign outM = outputM; 

    // PC
    wire tmp1;
    wire tmp2;
    wire tmp3;
    wire notzr;
    wire notng;
    wire ps;
    wire tmp;
    wire jump;
    wire inc;
    And ANDpc1(.a(ng),.b(j1),.out(tmp1));
    And ANDpc2(.a(zr),.b(j2),.out(tmp2));
    Not NOTpc1(.in(zr), .out(notzr));
    Not NOTpc2(.in(ng), .out(notng));
    And ANDpc3(.a(notzr),.b(notng),.out(ps));
    And ANDpc4(.a(ps),.b(j3),.out(tmp3));
    Or ORpc1(.a(tmp1),.b(tmp2),.out(tmp));
    Or ORpc2(.a(tmp),.b(tmp3),.out(jump));
    Not NOTpc3(.in(jump), .out(inc));
    	PC PC1(
    	.clk(clk),
		.reset(reset),
		.load(jump),
		.inc(inc),
		.in(Areg),
		.out(pc)
  	);

endmodule
