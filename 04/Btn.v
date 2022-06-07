`default_nettype none
module Btn(
    input btn,
	output wire[15:0] out
);
    assign out[0] = btn;
endmodule