sym-d:
	yosys -p "read_verilog DFF.v; synth_gowin -json DFF.json"
	nextpnr-gowin --json DFF.json --write pnrDFF.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k-d.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrDFF.json

flash:
	openFPGALoader -b tangnano4k pack.fs

compile-d:
	iverilog -o DFF.vvp DFF.v

compile-bit:
	iverilog -o Bit_tb.vvp Bit_tb.v

sim-bit:
	vvp Bit_tb.vvp

diff-bit:
	diff Bit.out Bit.cmp