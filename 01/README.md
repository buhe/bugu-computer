## 准备

作为一个软件工程师，计算机是我们赖以生存的工具，所有我们开发的软件都在计算机上执行，那么通过与或非等最基础的门电路构建一个计算机一方面可以更深入的了解计算机，一方面也可以指定我们更好的开发软件。

基于门电路从头开始当然可以，但连接电路比较费劲，所以这里采用了 verilog + Fpga 的形式。verilog + Fpga 本质就是自己设计连接电路，和自己从头基于门电路连接一样。

第一个项目来搭建开发环境和构建最基础的几个电路。

### 硬件

- tangnano 4k

硬件采用国产的 tangnano 而没有采用国外大厂的。一方面为了支持国产 IC 一方面中国做为主要以制造业为主的国家国产的 Fpga 性价比较高。

### 搭建环境

常见的 EDA 工具一般仅支持 windows 和 linux ，这里不对专有和开源软件的优劣做对比了，以免引战。在本教程中我尽量使用开源软件。

```bash
# 安装综合的工具
brew install yosys
pip install apycula
brew install eigen

# 安装 gowin 的布线工具
git clone git@github.com:YosysHQ/nextpnr.git
cmake . -DARCH=gowin
make -j$(nproc)
sudo make install
# 参考 https://github.com/YosysHQ/nextpnr#nextpnr-gowin

# 安装刷入 Fpga 的工具
brew install openfpgaloader --HEAD
```

综合和布线其实就是生产电路，和物理的连接电路一样，具体的 Fpga 的原理请参考 https://zh.wikipedia.org/zh-tw/%E7%8E%B0%E5%9C%BA%E5%8F%AF%E7%BC%96%E7%A8%8B%E9%80%BB%E8%BE%91%E9%97%A8%E9%98%B5%E5%88%97 。

### Nand

### 非

### 或

### 与

### 编译

```bash
iverilog -o Xor_tb.vvp Xor_tb.v
```



### 仿真（模拟）

```bash
vvp sample_tb.vvp
open -a gtkwave
```



### 上传到 tangnano

#### 综合

```bash
yosys -p "read_verilog Xor.v; synth_gowin -json Xor.json"
```



```bash
nextpnr-gowin --json Xor.json --write pnrXor.json --device GW1NSR-LV4CQN48PC6/I5 --cst tangnano4k.cst
```



```bash
gowin_pack -d GW1NSR-LV4CQN48PC6/I5 -o pack.fs pnrXor.json
```



#### 写入硬件

```bash
openFPGALoader -b tangnano4k pack.fs
```



#### 测试

### 结果
[<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h2qp7wk0ttj20c60iadh8.jpg" alt="" style="zoom:50%;" />](https://youtube.com/shorts/S9ERI2q2dWQ?feature=share)
