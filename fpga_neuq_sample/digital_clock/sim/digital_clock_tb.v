`timescale 1ns/1ps
module digital_clock_tb;

	reg clk;													//系统时钟：50MHZ
	reg rst_n;												//系统复位：低电平有效
	
	wire [2:0] sel;										//数码管位选信号
	wire [7:0] seg;										//数码管段选信号

	digital_clock digital_clock_inst(
		.clk(clk), 
		.rst_n(rst_n), 
		.sel(sel), 
		.seg(seg)
	);
	
	initial
	begin
		clk = 0;
		rst_n = 0;
		#200
		rst_n = 1;
	end
	
	always #10 clk = ~clk;								//50MHZs

endmodule 
