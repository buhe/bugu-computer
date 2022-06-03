/**
 * The ALU (Arithmetic Logic Unit).
 * Computes one of the following functions:
 * x+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y,
 * x+1, y+1, x-1, y-1, x&y, x|y on two 16-bit inputs, 
 * according to 6 input bits denoted zx,nx,zy,ny,f,no.
 * In addition, the ALU computes two 1-bit outputs:
 * if the ALU output == 0, zr is set to 1; otherwise zr is set to 0;
 * if the ALU output < 0, ng is set to 1; otherwise ng is set to 0.
 */

// Implementation: the ALU logic manipulates the x and y inputs
// and operates on the resulting values, as follows:
// if (zx == 1) set x = 0        // 16-bit constant
// if (nx == 1) set x = !x       // bitwise not
// if (zy == 1) set y = 0        // 16-bit constant
// if (ny == 1) set y = !y       // bitwise not
// if (f == 1)  set out = x + y  // integer 2's complement addition
// if (f == 0)  set out = x & y  // bitwise and
// if (no == 1) set out = !out   // bitwise not
// if (out == 0) set zr = 1
// if (out < 0) set ng = 1

`default_nettype none
module ALU(
	input wire [15:0] x,		// input x (16 bit)
	input wire [15:0] y,		// input y (16 bit)
    input wire zx, 				// zero the x input?
    input wire nx, 				// negate the x input?
    input wire zy, 				// zero the y input?
    input wire ny, 				// negate the y input?
    input wire f,  				// compute out = x + y (if 1) or x & y (if 0)
    input wire no, 				// negate the out output?
    output wire [15:0] out, 	// 16-bit output
    output wire zr, 			// 1 if (out == 0), 0 otherwise
    output wire ng 			// 1 if (out < 0),  0 otherwise
);

// your implementation comes here:

//    Mux16(a=x ,b=false ,sel=zx ,out=x1 );
//    Not16(in=x1, out=notx1);
//    Mux16(a=x1,b=notx1,sel=nx ,out=x2 );

//    Mux16(a=y ,b=false ,sel=zy ,out=y1 );
//    Not16(in=y1,out=noty1);
//    Mux16(a=y1,b=noty1,sel=ny ,out=y2 );

//    And16(a=x2 ,b=y2 ,out=andxy );
//    Add16(a=x2 ,b=y2 ,out=addxy );
//    Mux16(a=andxy,b=addxy,sel=f,out=xy);

//    Not16(in=xy,out=notxy);
//    Mux16(a=xy,b=notxy,sel=no,out[15]=tmp,out[0..7]=out07,out[8..15]=out815,out=out);

//    And(a=tmp,b=true,out=ng);
//    Or8Way(in=out07,out=tmp1);
//    Or8Way(in=out815,out=tmp2);
//    Or(a=tmp1,b=tmp2,out=tmp3);
//    Not(in=tmp3,out=zr);


endmodule
