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



### 激励

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

```bash
iverilog -o Xor_tb.vvp Xor_tb.v
```



### 仿真（模拟）

```bash
vvp sample_tb.vvp
open -a gtkwave
```



### 上传到 tangnano

#### 综合

```bash
yosys -p "read_verilog Xor.v; synth_gowin -json Xor.json"
```



```bash
nextpnr-gowin --json Xor.json --write pnrXor.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k.cst
```



```bash
gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrXor.json
```



#### 写入硬件

```bash
openFPGALoader -b tangnano4k pack.fs
```



#### 测试

### 结果
[<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h2qp7wk0ttj20c60iadh8.jpg" alt="" style="zoom:50%;" />](https://youtube.com/shorts/S9ERI2q2dWQ?feature=share)
