sym-half:
	yosys -p "read_verilog HalfAdder.v; synth_gowin -json HalfAdder.json"
	nextpnr-gowin --json HalfAdder.json --write pnrHalfAdder.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k-2i2o.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrHalfAdder.json

flash:
	openFPGALoader -b tangnano4k pack.fs