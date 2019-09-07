# FPGA
FPGA Demo
## and_gate
二输入与门（建模方式示例）
 - top1：顶层模块
 - and_gate：数据流建模（组合逻辑）
 - and_gate_behaviour_com：行为建模（组合逻辑）
 - and_gate_behaviour_timing：行为建模（时序逻辑电路）
## led_driver
LED驱动模块（流水灯）
 - led_driver：顶层模块
 - freq：分频模块（50MHz -> 1Hz）
 - led_run：流水模块（每间隔1s，LED灯流水一次，循环显示）
## seg_driver
数码管驱动模块
 - seg_driver：顶层模块
 - freq：分频模块（50MHz -> 1kHz）
 - seg7：数码管显示模块（6个数码管同时显示190905）
 - shift_data：数据位移模块（每间1s实现HELLO循环显示）
## digital_clock
数字钟
 - digital_clock：顶层模块
 - freq：分频模块（50MHz -> 1kHz）
 - clock_control：数字钟逻辑控制模块
 - bin_bcd：二进制转BCD模块（将输入的二进制数转换成BCD码）
 - seg7：数码管显示模块
## key_scan
矩阵键盘驱动模块
 - key_scan：矩阵键盘驱动模块
## calculator(生产实习结课作业)
计算器，可实现连续四则运算
 - calculator：顶层模块
 - freq：分频模块（50MHz -> 1kHz）
 - key_scan：矩阵键盘驱动模块
 - compute：计算逻辑控制模块
 - seg7：数码管显示模块
## document
FPGA管脚分配脚本（.tcl），开发板用户手册及状态机编写指南
## project_sample
新建工程文件夹模板
## project_sample
老师编写的所有程序源文件
## calculator_sample
计算器参考源文件
 
