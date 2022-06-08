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