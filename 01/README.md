## 布尔逻辑
大部分电路输入都大于两个，如 Mux 有三个输入，And16 甚至有 16 个输入。只有 DMux 有两个输入两个输出。

虽然 tangnaono 只有一个 led 能被程序控制，但 tangnano 有很多 gpio ，gpio 是通用接口，程序可以控制它产生高低电平（也就是 0 1 ）。可以把一个 led 接在 gpio 上（这里一端接到 2 一端接地）这样控制 gpio 的电平可以间接控制 led 的灯亮灭。

<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h2sts4gqr4j21400u0tgc.jpg" alt="IMG_1879" style="zoom: 25%;" />

### DMux

DMux 又称数据分配器。根据 sel 的信号分配 in 的信号，如果 sel 等于 0 则 a 等于 in 的信号，如果 sel 等于 1 则 b 等于 in 的信号。

```verilog
`include "Not.v"
`include "And.v"
`default_nettype none

module DMux(
	input wire in,
	input wire sel,
    output wire a,
	output wire b
);
    wire notsel;
    Not NOT2(.in(sel), .out(notsel));
	And AND1(.a(in),.b(notsel),.out(a));
	And AND2(.a(in),.b(sel),.out(b));

endmodule
```

约束文件如下：

```
IO_LOC "a" 10; // red
IO_LOC "in" 15;
IO_LOC "sel" 14; // right hand default 1
IO_LOC "b" 2; // blue
```

执行以下命令写入 Fpga

```bash
make sym-dmux

make flash
```

因为开关（14 也就是右边那个按钮）松开默认是 1 ，所以当写入 Fpga 后什么都不做，sel 等于 1 ，b 的信号等于 in 的信号，此时因为 in 绑定到按钮上（15 左边的按钮）也默认为 1 ，所以 b 为 1 ，连接到 gpio 2 的 led 发光（因为是 1 也就是高电平）。按下右边的按钮（sel），sel 等于 0 ，in 分配给了 a，红灯（10）亮，外接的 led（2）灭。

### 其他

这次的其他电路输入都大于 2 个，我们的 Fpga 只有两个按钮，在其上很难测试，虽然也可以连接额外的按钮，可 And16 有 16 个输入，同时按不现实，所以选择用仿真测试，以 And16 为例，其他同理。

And16 其实就是 16 个与门按位与：

```verilog
`include "Not.v"
`include "And.v"
`default_nettype none
module And16(
	input wire [15:0] a,
	input wire [15:0] b,
	output wire [15:0] out
);
    And AND1(.a(a[0]),.b(b[0]),.out(out[0]));
    And AND2(.a(a[1]),.b(b[1]),.out(out[1]));
    And AND3(.a(a[2]),.b(b[2]),.out(out[2]));
    And AND4(.a(a[3]),.b(b[3]),.out(out[3]));
    And AND5(.a(a[4]),.b(b[4]),.out(out[4]));
    And AND6(.a(a[5]),.b(b[5]),.out(out[5]));
    And AND7(.a(a[6]),.b(b[6]),.out(out[6]));
    And AND8(.a(a[7]),.b(b[7]),.out(out[7]));
    And AND9(.a(a[8]),.b(b[8]),.out(out[8]));
    And AND10(.a(a[9]),.b(b[9]),.out(out[9]));
    And AND11(.a(a[10]),.b(b[10]),.out(out[10]));
    And AND12(.a(a[11]),.b(b[11]),.out(out[11]));
    And AND13(.a(a[12]),.b(b[12]),.out(out[12]));
    And AND14(.a(a[13]),.b(b[13]),.out(out[13]));
    And AND15(.a(a[14]),.b(b[14]),.out(out[14]));
    And AND16(.a(a[15]),.b(b[15]),.out(out[15]));
endmodule
```

很简单，可以看到创建了 16 个与门，a b 每一位相与结果放在 out 的对应位。

编译，执行测试（仿真，激励）。

```bash
iverilog -o And16_tb.vvp And16_tb.v

vvp And16_tb.vvp
```

测试会把结果写入 *.out 文件里，然后和提供的 *.cmp 比较就可以了，如果一样就代表通过了。

```bash
diff And16.out And16.cmp
```



