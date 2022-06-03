## 算术（ALU）

### 半加器

半加器是不考虑来自进位的一位加法器。用二进制表示：

- 0 + 0 =00
- 1 + 0 = 01
- 0 + 1 = 01
- 1 + 1 = 10

因为有两个输入和两个输出，可以写入 Fpga 进行测试。两个输入对应两个按钮，两个输出对应两个 led ，执行：

```bash
yosys -p "read_verilog HalfAdder.v; synth_gowin -json HalfAdder.json"
nextpnr-gowin --json HalfAdder.json --write pnrHalfAdder.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k-2i2o.cst
gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrHalfAdder.json
	
openFPGALoader -b tangnano4k pack.fs
```

然后按下按钮测试，注意按钮松开的时候为 1 。

### 全加器

全加器是考虑来自进位的一位加法器。简单的说就是三个一位相加。真值表如：

| 输入 | 输出 |      |      |       |
| ---- | ---- | ---- | ---- | ----- |
| C    | A    | B    | sum  | carry |
| 0    | 0    | 0    | 0    | 0     |
| 0    | 0    | 1    | 1    | 0     |
| 0    | 1    | 0    | 1    | 0     |
| 0    | 1    | 1    | 0    | 1     |
| 1    | 0    | 0    | 1    | 0     |
| 1    | 0    | 1    | 0    | 1     |
| 1    | 1    | 0    | 0    | 1     |
| 1    | 1    | 1    | 1    | 1     |

全加器可以用两个半加器和一个或门实现。

```verilog
    wire hsum;
    wire hcarry;
    HalfAdder HalfAdder1(.a(a),.b(b),.sum(hsum),.carry(hcarry));
    wire hcarry2;
    HalfAdder HalfAdder2(.a(c),.b(hsum),.sum(sum),.carry(hcarry2));
    Or OR(.a(hcarry),.b(hcarry2),.out(carry));
```

- sum 很简单和 a + b + c 的 sum 相同。
- carry 则有点麻烦，a + b 和 a + b 的 sum + c，有一个进位则 carry 为 1。

### 16 进制加法器

其实就是 15 个全加器和 1 个半加器，因为最低位没有进位故采用半加器，其余各位都有低一位来自的进位，最高位的进位舍弃，我们称为溢出。

### 算术器

先看看注释：

```
// if (zx == 1) set x = 0        // 16-bit constant
// if (nx == 1) set x = !x       // bitwise not
// if (zy == 1) set y = 0        // 16-bit constant
// if (ny == 1) set y = !y       // bitwise not
// if (f == 1)  set out = x + y  // integer 2's complement addition
// if (f == 0)  set out = x & y  // bitwise and
// if (no == 1) set out = !out   // bitwise not
// if (out == 0) set zr = 1
// if (out < 0) set ng = 1
```

- 当 zx 等于 1 ，x 常为 16 进制的 0
- 当 nx 等于 1，x 取反。
- 当 zy 等于 1 ，y 常为 16 进制的 0
- 当 ny 等于 1，y 取反。
- 当 f 等于 1，输出 x + y
- 当 f 等于 0，输出 x & y
- 当 no 等于 1，输出取反。
- 当输出等于 0，zr 设为 1
- 当输出小于 0，ng 设为 1

减法、乘除法都可以转化成加法。逻辑运算也都可以转化为与非门（!(x & y) 就是与非门，可以通过设 f=0,no=1 来构建）。所以实现上述电路就可以计算所以算术。

```verilog
  wire[15:0] x1;
        wire[15:0] x2;
        wire[15:0] notx1;
    	Mux16 MUX16x(.a(x),.b(16'b0000000000000000),.sel(zx),.out(x1));
    	Not16 NOT16x(.in(x1),.out(notx1));
        Mux16 MUX16x1(.a(x1),.b(notx1),.sel(nx),.out(x2));

        wire[15:0] y1;
        wire[15:0] y2;
        wire[15:0] noty1;
    	Mux16 MUX16y(.a(y),.b(16'b0000000000000000),.sel(zy),.out(y1));
    	Not16 NOT16y(.in(y1),.out(noty1));
        Mux16 MUX16y1(.a(y1),.b(noty1),.sel(ny),.out(y2));

        wire[15:0] andxy;
        wire[15:0] addxy;
        wire[15:0] xy;
        And16 AND16xy(.a(x2),.b(y2),.out(andxy));
        Add16 ADD16xy(.a(x2),.b(y2),.out(addxy));
        Mux16 MUX16andadd(.a(andxy),.b(addxy),.sel(f),.out(xy));

        wire[15:0] notxy;
        Not16 NOT16xy(.in(xy),.out(notxy));
        Mux16 MUX16xy(.a(xy),.b(notxy),.sel(no),.out(out));
        wire tmp = out[15];
        wire[7:0] out07= out[7:0];
        wire[7:0] out815 = out[15:8];

        wire tmp1;
        wire tmp2;
        wire tmp3;
        And AND(.a(tmp),.b(1'b1),.out(ng));
        Or8Way OR8WAY07(.in(out07),.out(tmp1));
        Or8Way OR8WAY815(.in(out815),.out(tmp2));
        Or OR(.a(tmp1),.b(tmp2),.out(tmp3));
        Not NOT(.in(tmp3),.out(zr));
```

25 行之前很好理解，按部就班实现。

```verilog
				wire tmp = out[15];
        wire[7:0] out07= out[7:0];
        wire[7:0] out815 = out[15:8];

        wire tmp1;
        wire tmp2;
        wire tmp3;
/*line 8*/        And AND(.a(tmp),.b(1'b1),.out(ng));
        Or8Way OR8WAY07(.in(out07),.out(tmp1));
        Or8Way OR8WAY815(.in(out815),.out(tmp2));
        Or OR(.a(tmp1),.b(tmp2),.out(tmp3));
        Not NOT(.in(tmp3),.out(zr));
```

1. 按补码规定，最高位为 1 则整个数小于 0，所以第 8 行通过判断最高位是否为 1 来判断整个数是否小于 0。
2. 9、10、11 其实判断每位是否不为 0，如果每一位都为 0 则 tmp3 为 0。zr 是 tmp3 取反。