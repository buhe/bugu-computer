## 组装

### CPU

硬件和机器语言某种程度上是一一对应的，先确定机器语言再根据机器语言设计对应的硬件。

nand2tetris 的机器语言很简单，分为 A 指令和 C 指令，A 指令主要用来指定数字放进 A 寄存器中，C 指令用来访存，计算等。规范如下：

![n2t_4_4](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yslot438j20gl03pglu.jpg)



![n2t_4_5](https://tva1.sinaimg.cn/large/e6c9d24egy1h2ysm1labhj20hb04jaae.jpg)

规范没有什么特别的，人为设计的，指令等长、精简。

#### 操作目标和跳转规范


![n2t_4_7](https://tva1.sinaimg.cn/large/e6c9d24egy1h2ysnb6oboj20gy0620te.jpg)

![n2t_4_8](https://tva1.sinaimg.cn/large/e6c9d24egy1h2ysnji2tij20eq06kwev.jpg)

操作目标和跳转规则如上


```verilog
    wire d1;
    wire d2;
    wire d3;
    wire j1;
    wire j2;
    wire j3;
    And AND1(.a(instruction[15]),.b(instruction[5]),.out(d1));
    And AND2(.a(instruction[15]),.b(instruction[4]),.out(d2));
    And AND3(.a(instruction[15]),.b(instruction[3]),.out(d3));
    assign writeM = d3;
    And AND4(.a(instruction[15]),.b(instruction[2]),.out(j1));
    And AND5(.a(instruction[15]),.b(instruction[1]),.out(j2));
    And AND6(.a(instruction[15]),.b(instruction[0]),.out(j3));
```

通过这些简单的 verilog 来确定操作目标和跳转规则，d1 ~ d3 指定操作目标，j1 ~ j3 指定跳转规则，额外的 d3 付给 writeM 指定是否写内存。

#### A 寄存器

```verilog
    wire[15:0] outputM;
    wire[15:0] Ainput;
    wire Aload1;
    wire Aload;
    wire[15:0] Areg;
    Mux16 MUX16a(.a(instruction),.b(outputM),.sel(instruction[15]),.out(Ainput));
    Not NOT1(.in(instruction[15]), .out(Aload1));
    Or OR1(.a(Aload1),.b(d1),.out(Aload));
    Register REGISTERa(.in(Ainput),.load(Aload),.out(Areg), .clk(clk));
    assign addressM = Areg;
```

首先判断是 A 还是 C 指令，A 指令就按原本写入 A 寄存器，C 指令则操作目标是否含有 A 寄存器，如果含有把 ALU 的计算结果写入 A 寄存器。

#### D 寄存器

```verilog
    wire[15:0] Dreg;
    Register REGISTER1d(.in(outputM),.load(d2),.out(Dreg), .clk(clk));
```

如果操作目标含有 D 寄存器，则 ALU 的计算结果赋给 D 寄存器。

#### ALU

```verilog
wire[15:0] y;
    wire zr;
    wire ng;
    Mux16 MUX16alu(.a(Areg),.b(inM),.sel(instruction[12]),.out(y));
    ALU ALU(
	    .x(Dreg),
		.y(y),
        .zx(instruction[11]),
        .nx(instruction[10]),
        .zy(instruction[9]),
        .ny(instruction[8]),
        .f(instruction[7]),
        .no(instruction[6]),
	    .out(outputM),
	    .zr(zr),
	    .ng(ng)
	  );
      assign outM = outputM; 
```

![n2t_4_6](https://tva1.sinaimg.cn/large/e6c9d24egy1h2yt9ep6r9j20fa0d7aas.jpg)

根据指令的 12 ~ 6 位，决定 ALU 的计算规则。

#### PC

```verilog
    wire tmp1;
    wire tmp2;
    wire tmp3;
    wire notzr;
    wire notng;
    wire ps;
    wire tmp;
    wire jump;
    wire inc;
    And ANDpc1(.a(ng),.b(j1),.out(tmp1));
    And ANDpc2(.a(zr),.b(j2),.out(tmp2));
    Not NOTpc1(.in(zr), .out(notzr));
    Not NOTpc2(.in(ng), .out(notng));
    And ANDpc3(.a(notzr),.b(notng),.out(ps));
    And ANDpc4(.a(ps),.b(j3),.out(tmp3));
    Or ORpc1(.a(tmp1),.b(tmp2),.out(tmp));
    Or ORpc2(.a(tmp),.b(tmp3),.out(jump));
    Not NOTpc3(.in(jump), .out(inc));
    	PC PC1(
    	.clk(clk),
		.reset(reset),
		.load(jump),
		.inc(inc),
		.in(Areg),
		.out(pc)
  	);
```

使用 PC 的逻辑看似复杂，其实理解了想要干什么就简单了。当判断大于 0 的时候结果刚好大于 0，判断等于 0 时刚好等于 0，判断小于 0 时刚好小于 0 ，有一种情况满足则赋值 jump 为 1 ，否则 inc 为 1，然后通通给 PC ，结果就是：跳转的时候给 PC 赋值，其他情况 PC 加 1 。

### 内存

#### 布局


|address | memory|R/W|function|
|-|-|-|-|
|0-2047| RAM|R/W|R0--R15, static, stack, heap|
| 8192 - 第 14 位 | but - 16 位 |R/W|0 = button pressed, 1 = button released|
| 8193 - 第 14，1 位 | led - 16 位 |R/W|0 = led off, 1 = led on|

通过判断第 14 位，确定是访问 RAM 还是映射 IO 。

```verilog
   DMux DMUX1(
	    .in(load),
	    .sel(address[13]),
	    .a(loadRAM),
		.b(loadIO)
	  );
```

进而判断第 1 位，确定是访问按钮还是 LED 。

```verilog
  DMux DMUX2(
	    .in(loadIO),
	    .sel(address[0]),
	    .a(loadBtn),
		.b(loadLed)
	  );
```

通过抽象按钮和 LED 简化逻辑

```verilog
    // button - only read
    wire[15:0] outBtn;
    Btn BTN(.out(outBtn), .btn(btn));
    // led - only write
    wire[15:0] outLed;
    Led LED(.clk(clk), .in(in), .out(outLed), .load(loadLed), .led(led));
```

按钮的 verilog，当 btn 设为 0 则 out 为 16'b0000000000000000，反之为 16'b0000000000000001 。可见返回值依赖 btn 的值。

```verilog
`default_nettype none
module Btn(
    input btn,
	output wire[15:0] out
);
      Mux16 MUX161(
		.a(16'b0000000000000000),
		.b(16'b0000000000000001),
		.sel(btn),
	    .out(out)
	  );
endmodule
```

LED 的 verilog ，如果 load 为 1 则 in 的第一位替换 out 的第一位，反之则保留上一个状态，这里有个副作用是 assign led = prev; ，把当前的状态赋给 led 变量，进而改变 led 。然后把当前状态保存在 DFF 中。最后根据 out 的第一位返回 out 。

```verilog
`default_nettype none
module Led(
    input clk,
	input wire load,
    output wire led,
	output wire[15:0] out,
	input wire[15:0] in
);
    wire prev;
    Mux MUX(.a(outLow),.b(in[0]),.sel(load),.out(prev));
    assign led = prev;
    wire outLow;
	DFFusr DFF1(.clk(clk),.in(prev),.out(outLow));
     
  Mux16 MUX161(
		.a(16'b0000000000000000),
		.b(16'b0000000000000001),
		.sel(outLow),
	    .out(out)
	  );
endmodule
```

最后根据地址的第 14 位和第一位确定 memory 的最终返回值

```verilog
    Mux16 MUX161(
		.a(outBtn),
		.b(outLed),
		.sel(address[0]),
	    .out(tmp)
	  );
    
    Mux16 MUX162(
		.a(outRAM),
		.b(tmp),
		.sel(address[13]),
	    .out(out)
	  );
```

### ROM

ROM 和 RAM 差不多，不同的是加载了 led.hack 的二进制到 mem 中。然后根据 pc 返回 instruction ，由于开源的综合工具不能生成 block RAM ，所以这里只声明了 3 位 mem 以免使用过多 LUT 综合不了。

```verilog
`default_nettype none

module ROM(
	input wire [15:0] pc,
	output wire [15:0] instruction		
);

	// ROM file of hack
	parameter ROMFILE = "./led.hack";
	
	reg [15:0] mem [0:10];
	assign instruction = mem[pc[3:0]];
	
	initial begin
		$readmemb(ROMFILE,mem);
	end

endmodule
```

### 组装

最后把 CPU、Memory、ROM 组装起来。

```verilog
 wire [15:0] addressM;
    wire [15:0] outM;
    wire [15:0] instruction;
    wire [15:0] pc;
    wire [15:0] Mout;

    wire writeM;

	ROM ROM(
		.instruction(instruction),
		.pc(pc)
	);
	CPU CPU(
		.clk(clk_out),
		.inM(Mout),
		.instruction(instruction),
		.reset(~reset),
		.outM(outM),
		.writeM(writeM),
		.addressM(addressM),
		.pc(pc)
	);

	Memory MEMORY(
		.clk(clk_out),
		.address(addressM),
		.in(outM),
		.out(Mout),
		.load(writeM),
        .btn(btn),
        .led(led)
	);
```

1. ROM 根据 CPU 返回的 pc 产生指令
2. CPU 负责计算指令，通过 pc 指定下一条指令
3. CPU 如果要操作内存则把 address 提供给 Memory

