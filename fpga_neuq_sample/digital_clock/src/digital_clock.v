//数字钟顶层模块
module digital_clock(clk, rst_n, sel, seg);

	input clk;												//系统时钟：50MHZ
	input rst_n;											//系统复位：低电平有效
	
	output [2:0] sel;										//数码管位选信号
	output [7:0] seg;										//数码管段选信号
	
	wire clk_1khz;											//定义中间连线信号
	wire [23:0] data;										//定义中间连线信号
	wire [7:0] data_hour, data_min, data_sec;		//定义中间连线信号

	//分频模块：50MHZ---->1KHZ
	freq freq_dut(
		.clk(clk), 
		.rst_n(rst_n), 
		.clk_1khz(clk_1khz)
	);
	
	//数字钟逻辑控制模块
	clock_control #(.cnt_num(4)) clock_control_dut(		//仿真:#(.cnt_num(4))
		.clk(clk), 
		.rst_n(rst_n), 
		.data_out(data)
	);
	
	//二进制转BCD模块:小时
	bin_bcd bin_bcd_hour(
		.bin(data[23:16]), 
		.bcd(data_hour)
	);
	
	//二进制转BCD模块:分钟
	bin_bcd bin_bcd_min(
		.bin(data[15:8]), 
		.bcd(data_min)
	);
	
	//二进制转BCD模块:秒
	bin_bcd bin_bcd_sec(
		.bin(data[7:0]), 
		.bcd(data_sec)
	);
	
	//数码管显示模块
	seg7 seg7_dut(
		.clk_1khz(clk_1khz), 
		.rst_n(rst_n), 
		.data_in({data_hour, data_min, data_sec}), 
		.sel(sel), 
		.seg(seg)
	);
	
endmodule
