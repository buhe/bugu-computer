sym-dmux:
	yosys -p "read_verilog DMux.v; synth_gowin -json DMux.json"
	nextpnr-gowin --json DMux.json --write pnrDMux.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k-dmux.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrDMux.json

flash:
	openFPGALoader -b tangnano4k pack.fs

compile-mux:
	iverilog -o Mux_tb.vvp Mux_tb.v

sim-mux:
	vvp Mux_tb.vvp

diff-mux:
	diff Mux.out Mux.cmp

compile-and16:
	iverilog -o And16_tb.vvp And16_tb.v

sim-and16:
	vvp And16_tb.vvp

diff-and16:
	diff And16.out And16.cmp

compile-dmux4way:
	iverilog -o DMux4Way_tb.vvp DMux4Way_tb.v

sim-dmux4way:
	vvp DMux4Way_tb.vvp

diff-dmux4way:
	diff DMux4Way.out DMux4Way.cmp


compile-dmux8way:
	iverilog -o DMux8Way_tb.vvp DMux8Way_tb.v

sim-dmux8way:
	vvp DMux8Way_tb.vvp

diff-dmux8way:
	diff DMux8Way.out DMux8Way.cmp