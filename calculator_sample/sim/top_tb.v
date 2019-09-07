`timescale 1ns/1ps
module top_tb;

	reg clk;  //系统时钟
	reg rst_n;
	reg [3:0] row;  //矩阵键盘行信号
	
	wire [3:0] col;
	wire [2:0] sel;
	wire [7:0] seg;
	wire beep;
	
	reg [4:0] press_num;  //模拟按键
	
	top top_inst(
		.clk(clk),
		.rst_n(rst_n),
		.row(row),
		.col(col),
		.sel(sel),
		.seg(seg), 
		.beep(beep)
	);
	
	initial
	begin
		clk = 1;
		rst_n = 0;  //复位
		press_num = 5'd16; //抬起
		#200
		rst_n = 1;
		
		
		
		
		#100
		press_num = 5'd1;  //第一次按下按键1
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd10;  //第一次按下按键+
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd9;  //第一次按下按键9
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd15;  //第3次按下按键=
		#10000
		press_num = 5'd16; //抬起
		#10000
		

		
		
		
		
		#100
		press_num = 5'd9;  //第2次按下按键9
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd11;  //第2次按下按键-
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd1;  //第2次按下按键1
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd15;  //第3次按下按键=
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		
		
		
		#100
		press_num = 5'd9;  //第3次按下按键9
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd12;  //第3次按下按键*
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd1;  //第3次按下按键1
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd15;  //第3次按下按键=
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		
		
		
		#100
		press_num = 5'd9;  //第3次按下按键9
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd13;  //第3次按下按键/
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd1;  //第3次按下按键1
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		#100
		press_num = 5'd15;  //第3次按下按键=
		#10000
		press_num = 5'd16; //抬起
		#10000
		
		
		
		
		press_num = 5'd16; //抬起
		
		
		
		
	end
	
	always @ (*)
	begin
		if(!rst_n)
			begin
				press_num = 5'd16; //抬起
			end
		else
			begin
				case(press_num)
					5'd0	:	row = {1'b1,1'b1,1'b1,col[0]};
					5'd1	:	row = {1'b1,1'b1,1'b1,col[1]};
					5'd2	:	row = {1'b1,1'b1,1'b1,col[2]};
					5'd3	:	row = {1'b1,1'b1,1'b1,col[3]};
					
					5'd4	:	row = {1'b1,1'b1,col[0],1'b1};
					5'd5	:	row = {1'b1,1'b1,col[1],1'b1};
					5'd6	:	row = {1'b1,1'b1,col[2],1'b1};
					5'd7	:	row = {1'b1,1'b1,col[3],1'b1};
					
					5'd8	:	row = {1'b1,col[0],1'b1,1'b1};
					5'd9	:	row = {1'b1,col[1],1'b1,1'b1};
					5'd10	:	row = {1'b1,col[2],1'b1,1'b1};
					5'd11	:	row = {1'b1,col[3],1'b1,1'b1};
					
					5'd12	:	row = {col[0],1'b1,1'b1,1'b1};
					5'd13	:	row = {col[1],1'b1,1'b1,1'b1};
					5'd14	:	row = {col[2],1'b1,1'b1,1'b1};
					5'd15	:	row = {col[3],1'b1,1'b1,1'b1};
					
					5'd16	:	row = 4'b1111;
					default	:	row = 4'b1111;
				endcase
			end
	end
	
	always #10 clk = ~clk;
	
endmodule 	