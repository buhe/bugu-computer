compile-cpu:
	iverilog -o CPU_tb.vvp CPU_tb.v

sim-cpu:
	vvp CPU_tb.vvp

diff-bit:
	diff CPU.out CPU.cmp

compile-mem:
	iverilog -o Memory.vvp Memory.v

sim-mem:
	vvp CPU_tb.vvp

diff-mem:
	diff CPU.out CPU.cmp