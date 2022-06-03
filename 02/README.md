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

### 16 进制加法器

### 算术器



