/**
 * 16-bit register:
 * If load[t] == 1 then out[t+1] = in[t]
 * else out does not change
 */
`include "Bit.v"
`default_nettype none

module Register(
	input clk,
	input [15:0] in,
	input load,
	output [15:0] out
);
    // Bit(in=in[0], load=load, out=out[0]);   
    // Bit(in=in[1], load=load, out=out[1]);
    // Bit(in=in[2], load=load, out=out[2]);
    // Bit(in=in[3], load=load, out=out[3]);
    // Bit(in=in[4], load=load, out=out[4]);
    // Bit(in=in[5], load=load, out=out[5]);
    // Bit(in=in[6], load=load, out=out[6]);
    // Bit(in=in[7], load=load, out=out[7]);
    // Bit(in=in[8], load=load, out=out[8]);
    // Bit(in=in[9], load=load, out=out[9]);
    // Bit(in=in[10], load=load, out=out[10]);
    // Bit(in=in[11], load=load, out=out[11]);
    // Bit(in=in[12], load=load, out=out[12]);
    // Bit(in=in[13], load=load, out=out[13]);
    // Bit(in=in[14], load=load, out=out[14]);
    // Bit(in=in[15], load=load, out=out[15]);
    Bit BIT1(.in(in[0]),.load(load),.out(out[0]), .clk(clk));
    Bit BIT2(.in(in[1]),.load(load),.out(out[1]), .clk(clk));
    Bit BIT3(.in(in[2]),.load(load),.out(out[2]), .clk(clk));
    Bit BIT4(.in(in[3]),.load(load),.out(out[3]), .clk(clk));
    Bit BIT5(.in(in[4]),.load(load),.out(out[4]), .clk(clk));
    Bit BIT6(.in(in[5]),.load(load),.out(out[5]), .clk(clk));
    Bit BIT7(.in(in[6]),.load(load),.out(out[6]), .clk(clk));
    Bit BIT8(.in(in[7]),.load(load),.out(out[7]), .clk(clk));
    Bit BIT9(.in(in[8]),.load(load),.out(out[8]), .clk(clk));
    Bit BIT10(.in(in[9]),.load(load),.out(out[9]), .clk(clk));
    Bit BIT11(.in(in[10]),.load(load),.out(out[10]), .clk(clk));
    Bit BIT12(.in(in[11]),.load(load),.out(out[11]), .clk(clk));
    Bit BIT13(.in(in[12]),.load(load),.out(out[12]), .clk(clk));
    Bit BIT14(.in(in[13]),.load(load),.out(out[13]), .clk(clk));
    Bit BIT15(.in(in[14]),.load(load),.out(out[14]), .clk(clk));
    Bit BIT16(.in(in[15]),.load(load),.out(out[15]), .clk(clk));


endmodule
