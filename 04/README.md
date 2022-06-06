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
| 8192 | but|R/W|0 = button pressed, 1 = button released|
| 8193 | led|R/W|0 = led off, 1 = led on|
