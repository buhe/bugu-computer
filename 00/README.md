## 准备

作为一个软件工程师，计算机是我们赖以生存的工具，所有我们开发的软件都在计算机上执行，那么通过与或非等最基础的门电路构建一个计算机一方面可以更深入的了解计算机，一方面也可以更好的开发软件。

基于门电路从头开始当然可以，但连接电路比较费劲，所以这里采用了 verilog + Fpga 的形式。verilog + Fpga 本质就是自己设计连接电路，和自己从头基于门电路连接一样。

第一个项目来搭建开发环境和构建最基础的几个电路。

### 硬件

- tangnano 4k

硬件采用国产的 tangnano 而没有采用国外大厂的。一方面为了支持国产 IC 一方面中国是以制造业为主的国家、国产的 Fpga 性价比较高。

### 搭建环境

常见的 EDA 工具一般仅支持 windows 和 linux 不支持 macos，这里不对专有和开源软件的优劣做对比，以免引战。在本教程中我尽量使用开源软件而不使用厂家的专有软件。

```bash
# 安装综合的工具
brew install yosys
pip install apycula
brew install eigen

# 安装 gowin 的布线工具
git clone git@github.com:YosysHQ/nextpnr.git
cmake . -DARCH=gowin
make -j$(nproc)
sudo make install
# 参考 https://github.com/YosysHQ/nextpnr#nextpnr-gowin

# 安装刷入 Fpga 的工具
brew install openfpgaloader --HEAD

# 安装编译成可仿真的文件
brew install icarus-verilog

# 安装查看波形的软件
brew install --cask gtkwave
```

> 综合和布线其实就是生成电路，和物理的连接电路一样，具体的 Fpga 的原理请参考 https://zh.wikipedia.org/zh-tw/%E7%8E%B0%E5%9C%BA%E5%8F%AF%E7%BC%96%E7%A8%8B%E9%80%BB%E8%BE%91%E9%97%A8%E9%98%B5%E5%88%97 。

### Nand

Nand 又称为与非门，其他门一般通过它来构建，是基本门电路，原因如下：

1. 考虑电子元件的成本，也许从逻辑上来看与非门和或非门比与门和非门更复杂，但是实际上由于Mos管的物理结构，实现与非门和或非门需要的元件其实更少，成本更低，而简单的与门和或门其实在结构上比前者更复杂。
2. 或非门和与非门具有逻辑完备性，任何一个门通过组合可以实现任意电路，而与门和或门不具有这样的能力
3. 仍然和电子元件的物理结构有关，与非门和或非门实际运行效率比与门和或门更高。

与非门的真值表：

| A    | B    | A NAND B |
| ---- | ---- | -------- |
| 0    | 0    | 1        |
| 0    | 1    | 1        |
| 1    | 0    | 1        |
| 1    | 1    | 0        |

### 非

非门是用 Nand（与非门）实现的，代码如下：

```verilog
/**
 * Not gate:
 * out = not in
 */
`include "Nand.v"
`default_nettype none

module Not(
	input in,
	output out
);
Nand NAND(.a(in), .b(1'b1), .out(out));
endmodule
```

非门顾名思义就是取反操作，0 转成 1 ， 1 转成 0 。所以只要输入和 1 与然后取反就可以了，利用与非门很容易做到。

### 或

或门利用非门和与非门实现，a or b == not (not a and not b)，如果想了解这个公式怎么来的，请查阅“德摩根定律”。

```verilog
 /**
 * Or gate:
 * out = 1 if (a == 1 or b == 1)
 *       0 otherwise
 */
`default_nettype none
module Or(
	input a,
	input b,
	output out
);
    wire nota;
    wire notb;
    Not NOT1(.in(a), .out(nota));
    Not NOT2(.in(b), .out(notb));
    Nand NAND(.a(nota), .b(notb), .out(out));


endmodule
```

### 与

与门很简单，与非门的结果取反就行了。

```verilog
/**
 * And gate: 
 * out = 1 if (a == 1 and b == 1)
 *       0 otherwise
 */

`default_nettype none

module And(
	input a,
	input b,
	output out
);
    wire notaandb;

// your implementation comes here:
    Nand NAND(.a(a), .b(b), .out(notaandb));
    Not NOT(.in(notaandb), .out(out));


endmodule
```

### 异或

异或门是第一个有挑战的门电路，异或门的意义是两个输入不同结果为 1 ，w1 和 w2 分别断言 a = 1, b = 0 和 a = 0 , b = 1 ，w1 or w2 是上述有一个成立结果就为 1。因为 a b 只有两种取指，上述描述就覆盖了所有情况。

```verilog
/** 
* Xor (exclusive or) gate:
* If a<>b out=1 else out=0.
*/
`include "Not.v"
`include "And.v"
`include "Or.v"
`default_nettype none

module Xor(
	input wire a,
	input wire b,
	output wire out
);
	wire nota;		//new wire must be declared
	wire notb;
	Not NOT1(.in(a), .out(nota));	 //NOT1 is instance name
	Not NOT2(.in(b), .out(notb));
	
	wire w1;
	wire w2;
	And AND1(.a(a),.b(notb),.out(w1));
	And AND2(.a(nota),.b(b),.out(w2));

	Or OR(.a(w1),.b(w2),.out(out));
endmodule
```

真值表如下：

| A    | B    | A XOR B |
| ---- | ---- | ------- |
| 0    | 0    | 0       |
| 0    | 1    | 1       |
| 1    | 0    | 1       |
| 1    | 1    | 0       |

### 激励

所谓激励和软件工程师的单元测试差不多，以下激励就是用来测试异或门的，很好理解。

a = ... b= ... 就是给 a b 赋值来测试在不同取值下的结果。结果通过 display 写入Xor.out 文件中，波形写入 Xor_tb.vcd 中，待会介绍波形。

```verilog
`include "Xor.v"
`default_nettype none
module Xor_tb();

	integer file;

	reg a = 0;
	reg b = 0;
	wire out;
	
	Xor XOR(
	    .a(a),
		.b(b),
	    .out(out)
	  );

	task display;
    	#1 $fwrite(file, "| %1b | %1b | %1b |\n", a,b,out);
  	endtask
  	
  	initial begin
  		$dumpfile("Xor_tb.vcd");
  		$dumpvars(0, Xor_tb);
		file = $fopen("Xor.out","w");
    	$fwrite(file, "| a | b |out|\n");
		
		a=0;b=0;
		display();
  		
		a=0;b=1;
		display();
		
		a=1;b=0;
		display();
		
		a=1;b=1;
		display();
		$finish();	
	end

endmodule
```



### 编译

编译 Xor_tb.v，有编译错误在这步就会打印出来。

```bash
iverilog -o Xor_tb.vvp Xor_tb.v
```

### 仿真（模拟）

所谓仿真其实就是模拟，仿真其实就是模拟硬件，在不同的输入（信号）下展现不同的波形。

```bash
vvp sample_tb.vvp
open -a gtkwave
```

使用 gtkwave 查看波形，右键点击Xor_tb ，选择 a b out ，然后 append ，删除内部变量。可以看到当 a b 不同结果为 1 （高电平）。

#### ![Xor](https://tva1.sinaimg.cn/large/e6c9d24egy1h2sll4iicfj20x40abgmv.jpg)

#### 比较

*.cmp 是提供的比较文件， *.out 是我们执行仿真产生的结果文件。二者应该是相同的，采用这种方式来断言我们的程序写的对不对。

```bash
diff Xor.out Xor.cmp
```

如果程序写的对什么也不输出，否则输出不同的地方。

### 上传到 tangnano

#### 综合和布线

综合和布线就是通过 verilog 产生电路的过程。

```bash
yosys -p "read_verilog Xor.v; synth_gowin -json Xor.json"
```

综合比较简单，布线需要引入所谓的约束文件：

```
IO_LOC "out" 10;
IO_LOC "a" 15;
IO_LOC "b" 14;
```

14 和 15 是 tangnano 的两个按钮，分别被绑定到了 a b ，10 是 led 灯。需要注意的是按钮松开的时候是 1 ，按下是 0 。约束文件把程序中的变量绑定到了实际的物理硬件，改变物理量就改变了变量。

```bash
nextpnr-gowin --json Xor.json --write pnrXor.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k.cst
```

最后生成二进制文件。

```bash
gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrXor.json
```

#### 写入硬件

刷入 Fpga 。

```bash
openFPGALoader -b tangnano4k pack.fs
```

#### 测试

实际按下按钮试试。当按钮的状态不同时，结果为 1 ，反之结果为 0。完成了异或门。下面是视频，点击即可。

### 结果
[<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h2qp7wk0ttj20c60iadh8.jpg" alt="" style="zoom:50%;" />](https://youtube.com/shorts/S9ERI2q2dWQ?feature=share)



> 代码：https://github.com/buhe/bugu-computer/tree/master/00
