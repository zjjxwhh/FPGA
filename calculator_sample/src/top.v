module top(clk,rst_n,row,col,sel,seg, beep);
	
	input clk;
	input rst_n;
	input [3:0] row;
	
	output [3:0] col;
	output [2:0] sel;
	output [7:0] seg;
	output beep;
	
	wire flag;
	wire [23:0] data_mid;
	wire [3:0]  press_num;
	wire clk_1khz;
	
	//分频模块:产生1kHz时钟信号
	freq  freq_dut(
		.clk(clk),
		.rst_n(rst_n),
		.clk_1khz(clk_1khz)
	);

	//矩阵键盘驱动模块
	key_scan key_scan_dut(
		.clk(clk_1khz),
		.rst_n(rst_n),
		.row(row),
		.col(col),
		.flag(flag),
		.press_num(press_num)
	);
	
	//计算模块
	compute compute_dut(  //#(.cnt_num(4))
		.clk(clk_1khz),
		.rst_n(rst_n),
		.flag(flag),
		.data_out(data_mid),
		.press_num(press_num)
	);
	
//	//数码管驱动模块
//	seg_driver seg_driver_dut(
//		.clk(clk),
//		.rst_n(rst_n),
//		.data_in(data_mid),
//		.sel(sel),
//		.seg(seg)
//	);
	
	//6个数码管驱动模块：6个数码管可以显示
	seg7 seg7_dut(
		.clk_1khz(clk_1khz),
		.rst_n(rst_n),
		.data_in(data_mid),
		//.data_in(24'h190828),
		.sel(sel),
		.seg(seg)
	);
	
	beep_driver beep_driver_dut(
		.clk_1khz(clk_1khz), 
		.flag(flag), 
		.beep(beep)
	);

endmodule 