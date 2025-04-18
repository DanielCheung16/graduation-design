

# 基于RISCV-32I五级流水CPU的FPGA实现
 
### 目录

- [基于RISCV-32I五级流水CPU的FPGA实现](#基于riscv-32i五级流水cpu的fpga实现)
    - [目录](#目录)
    - [使用平台](#使用平台)
    - [安装步骤](#安装步骤)
    - [文件目录说明](#文件目录说明)
    - [指令集架构](#指令集架构)
    - [版本控制](#版本控制)


### 使用平台
FPGA: Genesys2  
Vivado：18.3  
ModelSim：SE-64 10.5

**注**：现vivado与modelsim的联合配置路径是作者电脑的路径。用户需自行配置。  
Vivado和Modelsim联合仿真教程：  
[vivado18.3和modelsim关联-CSDN博客](https://blog.csdn.net/baidu_25816669/article/details/135588889)  
[Modelsim的安装及Modelsim+Vivado联合仿真教程 - devindd - 博客园](https://www.cnblogs.com/devindd/articles/16837346.html)  

### 安装步骤


### 文件目录说明
```
.
├── CPU2.srcs
│   ├── constrs_1
│   │   └── new
│   ├── sim_1
│   │   └── new
│   └── sources_1
│       ├── imports
│       │   ├── HDMI
│       │   ├── new
│       │   └── vsrc
│       ├── ip
│       │   ├── bmem_ip
│       │   ├── clk_pll
│       │   ├── clk_pll2
│       │   ├── imem_ip
│       │   ├── ps2_fifo_0
│       │   ├── vga_ctrl_0
│       │   └── vga_gen_0
│       └── new
├── Init
└── waves

```  

主要关注**CPU2.srcs**，**Init**，**waves**三个文件夹。CPU2.srcs包含约束文件*constrs_1*，testbench*sim_1*，源代码*sources_1*。Init包含给imem和dmem初始化的裸机程序，以及显存和显存控制的初始化文件。waves包含加载波形的模板。  

**注1**：在修改了Init中的coe文件后需要在vivado命令行中输入：`generate_target simulation [get_ips  <your_ip_name>]`，从而更新ip核的网表。这是由于vivado并不会因为coe文件修改而从新生成ip核，这会导致仿真时仍旧使用的旧初始化数据。  
**注2**：（*后期写报告再完善*）




### 指令集架构
请阅读[RISCV中文指令集架构手册](http://riscvbook.com/chinese/RISC-V-Reader-Chinese-v2p1.pdf)   
中断请阅读[特权指令部分](https://www.scs.stanford.edu/~zyedidia/docs/riscv/riscv-privileged.pdf)。

### 版本控制
该项目使用Git进行版本管理。您可以在repository参看当前可用版本。





