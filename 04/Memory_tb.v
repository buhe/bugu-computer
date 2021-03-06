`include "Mux16.v"
`include "DMux.v"
`include "Btn.v"
`include "Led.v"

`include "Not.v"
`include "And.v"
`include "Or.v"
`include "DFFusr.v"
`include "RAM.v"
`include "Memory.v"
module Memory_tb();

integer file;
reg clk = 1;
reg [15:0] address = 16'h1FFC;
reg load = 1;
wire signed [15:0] out;
reg btn = 1;
wire led;
reg signed [15:0] in= 16'h0000;

Memory
  Memory1(
    .address(address),
	.load(load),
	.in(in),
	.led(led),
	.btn(btn),
	.out(out),
    .clk(clk)
  );

// always #1 address = address+1;
always #1 clk = ~clk;

	task display;
    	#1 $fwrite(file, "|%6d|  %1b  |%16b|%6d|  %1b  |  %1b  |\n",in,load,address,out,led,btn);
  	endtask

initial begin
    $dumpfile("Memory_tb.vcd");
    $dumpvars(0, Memory_tb);
    file = $fopen("Memory.out","w");
    $fwrite(file, "|  in  |load |    address     | out  | led | btn |\n");
    in = 12345;load=0;address=16'd8192;
    display();
    display();

    in=1;load=1;address=16'd8193;
    display();
    display();

    in=-1;load=1;address=16'h0000;
    display();
    display();

    in=9999;load=0;
    display();
    display();

    address=16'd1000;
    display();
    address=16'd1200;
    display();

    in=12345;load=1;address=16'h0000;
    display();
    display();

    address=16'd8193;
    display();
    display();

    in=2222;load=1;address=16'd1000;
    display();
    display();

    in=9999;load=0;
    display();
    display();

    address=16'h0000;
    display();
    address=16'd1200;
    display();

    load=0;address=16'h0001;
    display();
    address=16'h0002;
    display();



  $finish;
end

endmodule
