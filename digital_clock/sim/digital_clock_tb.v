`timescale 1ns/1ps
module digital_clock_tb;

	reg clk;
	reg rst_n;
	
	wire [2:0] sel;
	wire [7:0] seg;
	
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
	
	always #10 clk = ~clk;
	
endmodule 