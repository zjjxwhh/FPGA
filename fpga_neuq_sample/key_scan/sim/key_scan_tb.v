`timescale 1ns/1ps
module key_scan_tb;

	reg clk;													//系统时钟：50MHZ
	reg rst_n;												//系统复位：低电平有效
	reg [3:0] row;											//矩阵键盘行信号
	
	wire [3:0] col;										//矩阵键盘列信号
	wire flag;												//按键按下消抖完成后且确定按键行列的标志信号
	wire [3:0] data;										//输出键值
	
	reg [4:0] press_num;									//模拟按键动作 

	key_scan #(.cnt_num(4)) key_scan_inst(
		.clk(clk), 
		.rst_n(rst_n), 
		.row(row), 
		.col(col), 
		.flag(flag), 
		.data(data)
	);
	
	initial
	begin
		clk = 0;
		rst_n = 0;											//复位
		press_num = 5'd16;								//抬起
		#200
		rst_n = 1;
		
		#100
		press_num = 5'd1;									//第一次按下按键为1
		#10000
		press_num = 5'd16;								//第一次按键抬起
		#10000
		
		press_num = 5'd5;									//第二次按下按键为5
		#10000
		press_num = 5'd16;								//第二次按键抬起
		#10000
		
		press_num = 5'd10;								//第三次按下按键为10
		#10000
		press_num = 5'd16;								//第三次按键抬起
		#10000
		
		press_num = 5'd15;								//第四次按下按键为15
		#10000
		press_num = 5'd16;								//第四次按键抬起
		#10000
		$stop;
	end
	
	//模拟按键动作
	always @ (*)
	begin
		if(!rst_n)
			press_num = 5'd16;
		else
			begin
				case(press_num)
					5'd0	:	row = {1'b1, 1'b1, 1'b1, col[0]};		//"0"
					5'd1	:	row = {1'b1, 1'b1, 1'b1, col[1]};		//"1"
					5'd2	:	row = {1'b1, 1'b1, 1'b1, col[2]};		//"2"
					5'd3	:	row = {1'b1, 1'b1, 1'b1, col[3]};		//"3"
					
					5'd4	:	row = {1'b1, 1'b1, col[0], 1'b1};		//"4"
					5'd5	:	row = {1'b1, 1'b1, col[1], 1'b1};		//"5"
					5'd6	:	row = {1'b1, 1'b1, col[2], 1'b1};		//"6"
					5'd7	:	row = {1'b1, 1'b1, col[3], 1'b1};		//"7"
					
					5'd8	:	row = {1'b1, col[0], 1'b1, 1'b1};		//"8"
					5'd9	:	row = {1'b1, col[1], 1'b1, 1'b1};		//"9"
					5'd10	:	row = {1'b1, col[2], 1'b1, 1'b1};		//"10"
					5'd11	:	row = {1'b1, col[3], 1'b1, 1'b1};		//"11"
					
					5'd12	:	row = {col[0], 1'b1, 1'b1, 1'b1};		//"12"
					5'd13	:	row = {col[1], 1'b1, 1'b1, 1'b1};		//"13"
					5'd14	:	row = {col[2], 1'b1, 1'b1, 1'b1};		//"14"
					5'd15	:	row = {col[3], 1'b1, 1'b1, 1'b1};		//"15"
					
					5'd16	:	row = 4'b1111;									//抬起
					default	:	row = 4'b1111;								//抬起
				endcase
			end
	end
	
	always #10 clk = ~clk;

endmodule 
