compile:
	iverilog -o Xor_tb.vvp Xor_tb.v

sim:
	vvp Xor_tb.vvp

diff:
	diff Xor.out Xor.cmp

sym:
	yosys -p "read_verilog Xor.v; synth_gowin -json Xor.json"
	nextpnr-gowin --json Xor.json --write pnrXor.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrXor.json

flash:
	openFPGALoader -b tangnano4k pack.fs