module calculator(clk, rst_n, row, col, sel, seg);
	
	input clk;
	input rst_n;
	input [3:0] row;
	
	output [3:0] col;
	output [2:0] sel;
	output [7:0] seg;

	wire clk_1khz;
	wire flag;
	wire [23:0] data_press;
	wire [23:0] data_display;
	
	freq /*#(.cnt_num(4))*/ freq_inst(
		.clk(clk),
		.rst_n(rst_n),
		.clk_1khz(clk_1khz)
	);
	
	key_scan key_scan_inst(
		.clk(clk),
		.rst_n(rst_n),
		.row(row),
		.col(col),
		.flag(flag),
		.data_out(data_press)
	);
	
	
	compute compute_inst(
		.clk(clk),
		.rst_n(rst_n),
		.data_in(data_press),
		.flag(flag),
		.data_out(data_display)
	);
	
	seg7 seg7_inst(
		.clk_1khz(clk_1khz),
		.rst_n(rst_n),
		.data_in(data_display),
		.sel(sel),
		.seg(seg)
	);

endmodule 