`default_nettype none

module Led(
    input clk,
	input wire load,
    output wire led,
	output wire[15:0] out,
	input wire[15:0] in
);
    wire prev;
    Mux MUX(.a(outLow),.b(in[0]),.sel(load),.out(prev));
    assign led = prev;
    wire outLow;
	DFFusr DFF1(.clk(clk),.in(prev),.out(outLow));
          Mux16 MUX161(
		.a(16'b0000000000000000),
		.b(16'b0000000000000001),
		.sel(outLow),
	    .out(out)
	  );

endmodule