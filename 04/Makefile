compile-cpu:
	iverilog -o CPU_tb.vvp CPU_tb.v

sim-cpu:
	vvp CPU_tb.vvp

diff-cpu:
	diff CPU.out CPU.cmp

compile-mem:
	iverilog -o Memory_tb.vvp Memory_tb.v

sim-mem:
	vvp Memory_tb.vvp

diff-mem:
	diff Memory.out Memory.cmp

compile-rom:
	iverilog -o ROM.vvp ROM.v

compile-com:
	iverilog -o Computer_tb.vvp Computer_tb.v

sim-com:
	vvp Computer_tb.vvp

diff-com:
	diff Computer.out Computer.cmp

sym-com:
	yosys -p "read_verilog Computer.v; synth_gowin -json Computer.json"
	nextpnr-gowin --json Computer.json --write pnrComputer.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k-com.cst
	gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrComputer.json

flash:
	openFPGALoader -b tangnano4k pack.fs