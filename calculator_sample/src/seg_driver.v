//顶层模块：数码管驱动设计
module seg_driver(clk,rst_n,data_in,sel,seg);
	
	input clk;  //系统时钟：50MHZ
	input rst_n;  //系统复位：低电平有效
	input [23:0] data_in;  //输入数据，一个数码管需要4位二进制数据
	
	output [2:0] sel;  //数码管位选信号
	output [7:0] seg;  //数码管段选信号
	
	wire clk_1khz;  //定义的中间连线
	
	//分频模块
	freq freq_dut(
		.clk(clk),
		.rst_n(rst_n),
		.clk_1khz(clk_1khz)
	);

	//6个数码管驱动模块：6个数码管可以显示
	seg7 seg7_dut(
		.clk_1khz(clk_1khz),
		.rst_n(rst_n),
		.data_in(data_in),
		//.data_in(24'h190828),
		.sel(sel),
		.seg(seg)
	);
	
endmodule 