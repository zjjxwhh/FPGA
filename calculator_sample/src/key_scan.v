//矩阵键盘驱动模块
module key_scan (clk, rst_n, row, col, flag, press_num);

//	input clk;  //系统时钟
	input clk;
	input rst_n;
	input [3:0] row;  //矩阵键盘行信号
	
	output reg [3:0] col;  //矩阵键盘列信号
	output reg flag;   //按键按下稳定后的标志信号
	output reg [3:0] press_num;  //键值
	
//	/********************分频***********************/
//	reg [19:0] cnt;  //计数器
//	reg clk_1khz;
//	
//	parameter cnt_num = 50_000_000 / 1000 / 2 - 1;  //0.5ms
//	
//	always @ (posedge clk or negedge rst_n)
//	begin
//		if(!rst_n)
//			begin
//				cnt <= 20'd0;  //计数器清零
//				clk_1khz <= 1'b0;  //1khz信号清零
//			end
//		else
//			begin
//				if(cnt < cnt_num)  //计数器没有到0.5ms
//					begin
//						cnt = cnt +20'd1;  //计数器自加一
//					end
//				else              //计数器计数到0.5ms
//					begin
//						clk_1khz = ~clk_1khz;  
//						cnt <= 20'd0;
//					end
//			end
//	end
	
	/***********************矩阵键盘驱动****************************/
	reg [1:0] state;  //状态寄存器
	reg [3:0] cnt_time;  //记录1ms次数
	reg [7:0] row_col;  //键值存储器
	
	
	`define s0 2'b00  //定参
	`define s1 2'b01
	`define s2 2'b10
	
	always @ (posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				state <= `s0;  //状态停在s0
				cnt_time <= 4'd0;  //计数器记录1s初始为0
				col <= 4'h0;  //列信号初始为0
				row_col <= 8'h0;  //键值存储器为0
				flag <= 1'b0;  //标志信号为假
			end
		else
			begin
				case(state)
					`s0	:	begin
									if(row != 4'b1111)  //有键按下
										begin
											if(cnt_time < 4'd9)  //消抖没有完成
												begin
													cnt_time <= cnt_time + 4'd1;  //记录1ms次数自加一
													flag <= 1'b0;  //按键未处于稳定（抖动）
												end
											else
												begin
													cnt_time <= 4'd0;  //计数器清零
													flag <= 1'b0;  //标志信号为0
													col <= 4'b0111;  //准备低电平扫描的列信号
													state <= `s1;  //状态跳到s1
												end
										end
									else                //无键按下
										begin
											state <= `s0;  //状态在s0等待
											cnt_time <= 4'd0;
											flag <= 1'b0;
										end
								end
					
					`s1	:	begin
									if(row != 4'b1111)  //处于扫描列4'b0111
										begin
											flag <= 1'b1;  //检测按键稳定并确定键位置
											row_col <= {row,col};  //存储键的位置（行，列）
											col <= 4'h0;  //对按键抬起做准备
											state <= `s2;  //状态跳转s2
										end	
									else                //未处于扫描列4‘b0111
										begin
											col <= {col[0],col[3:1]};  //进行循环扫描（）
											state <= `s1;  //状态在s1进行判断
											flag <= 1'b0;  //标志信号为0
										end
								end
								
					`s2	:	begin
									if(row == 4'b1111)  //按键抬起
										begin
											if(cnt_time < 4'd9)  //消抖未完成
												begin
													cnt_time <= cnt_time + 4'd1;  //记录1ms次数自加一
													flag <= 1'b0;  //标志信号为0
												end
											else           //消抖完成
												begin
													cnt_time <= 4'd0;  //计数器清零
													flag <= 1'b0;  //标志信号为0
													state <= `s0;  //状态跳到s0(方便下次重新按键)
												end
										end	
									else                //按键未抬起
										begin
											state <= `s2;  //等待按键抬起
											flag <= 1'b0;  //标志信号为0
											cnt_time <= 4'd0;  //计数器清零
										end
								end
					
					default	:	state <= `s0;  //安全行为
				endcase
			end
	end
	
	/***************对存储的按键位置（行列）进行编码译码*****************/
	always @ (*)
	begin
		if(!rst_n)
			begin
				press_num = 4'd0;  //键值为0
			end
		else
			begin
				case(row_col)
					8'b1110_1110	:	press_num = 4'd0;
					8'b1110_1101	:	press_num = 4'd1;
					8'b1110_1011	:	press_num = 4'd2;
					8'b1110_0111	:	press_num = 4'd3;
					
					8'b1101_1110	:	press_num = 4'd4;
					8'b1101_1101	:	press_num = 4'd5;
					8'b1101_1011	:	press_num = 4'd6;
					8'b1101_0111	:	press_num = 4'd7;
					
					8'b1011_1110	:	press_num = 4'd8;
					8'b1011_1101	:	press_num = 4'd9;
					8'b1011_1011	:	press_num = 4'd10;  
					8'b1011_0111	:	press_num = 4'd11; 
					
					8'b0111_1110	:	press_num = 4'd12; 
					8'b0111_1101	:	press_num = 4'd13;
					8'b0111_1011	:	press_num = 4'd14; 
					8'b0111_0111	:	press_num = 4'd15;
				endcase
			end
	end
endmodule 