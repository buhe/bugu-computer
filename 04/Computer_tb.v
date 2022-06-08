`include "Computer.v"
module Computer_tb();

reg clk_in = 0;
reg btn = 1;
wire led;
reg reset = 1;

Computer
  HACK1(
    .clk_in(clk_in),
    .btn(btn),
    .led(led),
    .reset(reset)
  );

always #1 clk_in = ~clk_in;

initial begin
  $dumpfile("Computer_tb.vcd");
  $dumpvars(0, Computer_tb);
#150
  $finish;
end

endmodule
