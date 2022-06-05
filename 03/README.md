## 时序电路（存储）

### 时序电路

所谓时序电路就是含有时钟信号的电路，时钟信号上下翻转

### D 触发器

因为 D 触发器只有一个输入和一个输出，可以用硬件测试。因为 D 触发器是时钟触发的，所以约束文件一定要带上时钟。

```
IO_LOC "out" 10; // red
IO_LOC "in" 15;
IO_LOC "clk" 45;
```

D 触发器具有存储功能，其实是通过反馈实现的，所以我们用它来实现存储电路。

### Bit

bit 是一位存储，由 D 触发器实现。和单纯的 D 触发器不同，额外使用了数据选择器实现数据的改变。

```verilog
    wire muxo;
    Mux MUX(.a(out),.b(in),.sel(load),.out(muxo));
		DFFusr DFF1(.clk(clk),.in(muxo),.out(out));
```

当 load = 1 时，D 触发器的输入被改变，所以 D 触发器的下一个状态改变。

因为时序电路用到了 clk ，所以仿真时 clk 不会自动变化，需要添加 always #1 clk = ~clk; 来使 clk 每隔一个时钟周期翻转一次。

### 寄存器

因为我们要构建的计算机是 16 位的，所以寄存器是 16 位的，寄存器由 16 个 Bit 组成。

```verilog
    Bit BIT1(.in(in[0]),.load(load),.out(out[0]), .clk(clk));
    Bit BIT2(.in(in[1]),.load(load),.out(out[1]), .clk(clk));
    Bit BIT3(.in(in[2]),.load(load),.out(out[2]), .clk(clk));
    Bit BIT4(.in(in[3]),.load(load),.out(out[3]), .clk(clk));
    Bit BIT5(.in(in[4]),.load(load),.out(out[4]), .clk(clk));
    Bit BIT6(.in(in[5]),.load(load),.out(out[5]), .clk(clk));
    Bit BIT7(.in(in[6]),.load(load),.out(out[6]), .clk(clk));
    Bit BIT8(.in(in[7]),.load(load),.out(out[7]), .clk(clk));
    Bit BIT9(.in(in[8]),.load(load),.out(out[8]), .clk(clk));
    Bit BIT10(.in(in[9]),.load(load),.out(out[9]), .clk(clk));
    Bit BIT11(.in(in[10]),.load(load),.out(out[10]), .clk(clk));
    Bit BIT12(.in(in[11]),.load(load),.out(out[11]), .clk(clk));
    Bit BIT13(.in(in[12]),.load(load),.out(out[12]), .clk(clk));
    Bit BIT14(.in(in[13]),.load(load),.out(out[13]), .clk(clk));
    Bit BIT15(.in(in[14]),.load(load),.out(out[14]), .clk(clk));
    Bit BIT16(.in(in[15]),.load(load),.out(out[15]), .clk(clk));
```

### PC

PC 又称程序计数器，主要由寄存器实现。PC 有三个条件，分别为 reset load inc 。由三个二选一数据选择器实现，先后次序决定优先级，加 1 由加法器实现。

有三个功能：

- 当 inc = 1 时，加 1
- 当 load = 1 时，把 in 的值赋给 PC
- 当 reset = 1 时，复位



### 主存(RAM)

