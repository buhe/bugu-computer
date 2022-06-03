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

### 加 1



### 算术器



