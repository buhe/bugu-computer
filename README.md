## bugu computer

![Untitled (3)](https://tva1.sinaimg.cn/large/008i3skNgy1gyomf2sm6zj30pm0be74x.jpg)

从与或非门开始构建一个计算机的教程（写给软件工程师）

作为一个软件工程师一定想过自己构建计算机，自己构建计算机是不是要连电路呀？得益于科技的发展，现在使用 verilog + Fpga 就可以了。本教程采用 verilog + Fpga 来从头构建一个最简单的计算机。

指令集采用 nand2tetris 的 Hack 。目标是运行如下汇编，不过也可以运行其他汇编因为是通用计算机。

```asm
// led.asm
// execute an infinite loop to
// read the button state and write the result

(LOOP)
@8193		//read BUT
D=M

@8192		//write LED
M=D

@LOOP
0;JMP
```



- [00 准备](00/)
- [01 布尔逻辑](01/)
- [02 算术（ALU）](02/)
- [03 时序电路（存储）](03/)
- [04 组装](04/)

参考

- https://gitlab.com/x653/nand2tetris-fpga
- https://www.nand2tetris.org/
