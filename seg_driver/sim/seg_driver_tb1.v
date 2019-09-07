`timescale 1ns/1ps
module seg_driver_tb1;

	reg clk;						//系统时钟：50MHZ
	reg rst_n;					//系统复位：低电平有效
	
	wire [2:0] sel;			//数码管位选信号
	wire [7:0] seg;

	seg_driver seg_driver_inst(
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
	
	always #10 clk = ~clk;
	
endmodule 