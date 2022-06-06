## 组装

### CPU

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



```verilog
    wire[15:0] Dreg;
    Register REGISTER1d(.in(outputM),.load(d2),.out(Dreg), .clk(clk));
```



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



### 内存

#### 布局


|address | memory|R/W|function|
|-|-|-|-|
|0-2047| RAM|R/W|R0--R15, static, stack, heap|
| 8192 | but|R/W|0 = button pressed, 1 = button released|
| 8193 | led|R/W|0 = led off, 1 = led on|
