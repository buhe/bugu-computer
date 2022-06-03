sym-half:
	yosys -p "read_verilog HalfAdder.v; synth_gowin -json HalfAdder.json"
	nextpnr-gowin --json HalfAdder.json --write pnrHalfAdder.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k-2i2o.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrHalfAdder.json

flash:
	openFPGALoader -b tangnano4k pack.fs

compile-full:
	iverilog -o FullAdder_tb.vvp FullAdder_tb.v

sim-full:
	vvp FullAdder_tb.vvp

diff-full:
	diff FullAdder.out FullAdder.cmp

compile-add16:
	iverilog -o Add16_tb.vvp Add16_tb.v

sim-add16:
	vvp Add16_tb.vvp

diff-add16:
	diff Add16.out Add16.cmp

compile-alu:
	iverilog -o ALU.vvp ALU.v