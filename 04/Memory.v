/**
* Memory mapped IO
*
* Big Multiplexer/Demultiplexer to address Memory.
*
* if (load==1) and (address[13]==0) loadRAM=1
* if (load==1) and (address[13]==1 and address[3:0]==0000) load0000=1
* if (load==1) and (address[13]==1 and address[3:0]==0001) load0001=1
* if (load==1) and (address[13]==1 and address[3:0]==0010) load0010=1
* ...
* if (address[13]==0) data = dataRAM
* if (address[13]==1 and address[3:0]=0000) data = data0000
* if (address[13]==1 and address[3:0]=0001) data = data0001
* if (address[13]==1 and address[3:0]=0010) data = data0010
*/

`default_nettype none
module Memory(
    input clk,
	input wire [15:0] address,
	input wire load,
	input wire btn,
	output wire led,
	output wire [15:0] out,
	input wire [15:0] in
);

//your implementation comes here:
    // DMux(in=load ,sel=address[14] ,a=load1 ,b=load2 );
    // DMux(in=load2,sel=address[13] ,a=load21,b=load22);
    // RAM16K(in=in ,load=load1 ,address=address[0..13] ,out=out1 );
    // Screen(in=in ,load=load21 ,address=address[0..12] ,out=out2 );
    // Keyboard(out= out3);
    // Mux16(a=out2 ,b=out3 ,sel=address[13] ,out=tmp);
    // Mux16(a=out1 ,b=tmp ,sel=address[14] ,out=out );

    wire loadRAM;
    wire loadIO;
    wire loadBtn;
    wire loadLed;
    DMux DMUX1(
	    .in(load),
	    .sel(address[13]),
	    .a(loadRAM),
		.b(loadIO)
	  );
    DMux DMUX2(
	    .in(loadIO),
	    .sel(address[0]),
	    .a(loadBtn),
		.b(loadLed)
	  );

    wire[15:0] outRAM;
    RAM RAM1(
    	.clk(clk),
		.address(address),
		.load(loadRAM),
		.in(in),
		.out(outRAM)
  	);

    // button - only read
    wire[15:0] outBtn;
    Btn BTN(.out(outBtn), .btn(btn));
    // led - only write
    wire[15:0] outLed;
    Led LED(.clk(clk), .in(in), .out(outLed), .load(loadLed), .led(led));
    
    wire[15:0] tmp;
    Mux16 MUX161(
		.a(outBtn),
		.b(outLed),
		.sel(address[0]),
	    .out(tmp)
	  );
    
    Mux16 MUX162(
		.a(outRAM),
		.b(tmp),
		.sel(address[10]),
	    .out(out)
	  );
    






endmodule	
