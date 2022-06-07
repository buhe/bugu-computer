`default_nettype none
module Btn(
    input btn,
	output wire[15:0] out
);
      Mux16 MUX161(
		.a(16'b0000000000000000),
		.b(16'b0000000000000001),
		.sel(btn),
	    .out(out)
	  );
endmodule