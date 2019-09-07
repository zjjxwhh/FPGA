`timescale 1ns/1ps
module seg_driver_tb;

	reg clk;						//系统时钟：50MHZ
	reg rst_n;					//系统复位：低电平有效
//	reg [23:0] data_in;
	
	wire [2:0] sel;			//数码管位选信号
	wire [7:0] seg;

	seg_driver seg_driver_inst(
		.clk(clk),
		.rst_n(rst_n),
//		.data_in(data_in),
		.sel(sel),
		.seg(seg)
	);
	
	initial
	begin
		clk = 0;							//复位
		rst_n = 0;
//		data_in = 24'h0;
		#200
		rst_n = 1;						//置位
//		data_in = 24'h190905;
	end
	
	always #10 clk = ~clk;
	
endmodule 