sym-dmux:
	yosys -p "read_verilog DMux.v; synth_gowin -json DMux.json"
	nextpnr-gowin --json DMux.json --write pnrDMux.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrDMux.json

flash:
	openFPGALoader -b tangnano4k pack.fs