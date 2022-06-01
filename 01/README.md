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

因为开关（14 也就是右边那个按钮）松开默认是 1 ，所以当写入 Fpga 后什么都不做，sel 等于 1 ，b 的信号等于 in 的信号，此时因为 in 绑定到按钮上（15 左边的按钮）也默认为 1 ，所以 b 为 1 ，连接到 gpio 2 的 led 发光（因为是 1 也就是高电平）。按下右边的按钮（sel），sel 等于 0 ，in 分配给了 a，红灯（10）亮，外接的 led（2）灭。

### 其他

