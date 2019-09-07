//矩阵键盘驱动模块
module key_scan(clk, rst_n, row, col, flag, data);

	input clk;													//系统时钟：50MHZ
	input rst_n;												//系统复位：低电平有效
	input [3:0] row;											//矩阵键盘行信号
	
	output reg [3:0] col;									//矩阵键盘列信号
	output reg flag;											//按键按下消抖完成后且确定按键行列的标志信号
	output reg [3:0] data;									//输出键值

	/***********分频：50MHZ---->1KHZ**************/
	reg [31:0] cnt;											//定义计数器
	reg clk_1khz;												//定义1KHZ信号
	
	parameter cnt_num = 50_000_000 / 1000 / 2 - 1;	//0.5ms
	
	always @ (posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cnt <= 32'd0;									//计数器清零
				clk_1khz <= 1'b0;								//1KHZ初始为0
			end
		else
			begin
				if(cnt < cnt_num)								//计数器没有计数到0.5ms
					begin
						cnt <= cnt + 32'd1;					//计数器自加一
					end
				else												//计数器计数到0.5ms
					begin
						cnt <= 32'd0;							//计数器清零
						clk_1khz <= ~clk_1khz;				//时钟取反(1ms)
					end
			end
	end
	
	/************矩阵键盘驱动设计************/
	reg [1:0] state;											//定义状态寄存器
	reg [3:0] cnt_time;										//记录1ms次数的存储器(10ms)
	reg [7:0] row_col;										//按键所在位置的行和列(键值存储器)
	
	parameter s0 = 2'b00;									//定参
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	
	always @ (posedge clk_1khz or negedge rst_n)
	begin
		if(!rst_n)
			begin
				state <= s0;									//状态停在s0
				cnt_time <= 4'd0;								//记录1ms次数存储器初始为0
				row_col <= 8'd0;								//键值存储器初始为0
				col <= 4'b0;									//列信号初始为0
				flag <= 1'b0;									//标志信号初始为0
			end
		else
			begin
				case(state)										//状态机设计
					s0	:	begin
								if(row != 4'b1111)			//矩阵键盘有按键按下
									begin
										if(cnt_time < 4'd9)	//没有消抖完成
											begin
												cnt_time <= cnt_time + 4'd1;	//计数器自加一
												flag <= 1'b0;	//标志信号为0
											end
										else						//消抖完成
											begin	
												cnt_time <= 4'd0;					//计数器清零
												flag <= 1'b0;						//标志信号为0
												col <= 4'b0111;					//给一列低电平(进行低电平列扫描)
												state <= s1;						//状态跳转s1
											end
									end
								else								//矩阵键盘没有按键按下
									begin
										cnt_time <= 4'd0;		//计数器为0
										flag <= 1'b0;			//标志信号为0
										state <= s0;			//状态在s0等待
									end
							end
							
					s1	:	begin
								if(row != 4'b1111)			//在最高列有按键按下
									begin
										flag <= 1'b1;			//标志信号为1
										row_col <= {row,col};	//存储键值(按键的行和列)
										col <= 4'b0;			//准备按键的抬起
										state <= s2;			//状态停在s2
									end
								else								//在最高列没有按键按下
									begin
										col <= {col[0],col[3:1]};	//列信号进行循环扫描
										state <= s1;			//状态在s1等着，重复按键在当前列按下的动作
										flag <= 1'b0;			//标志信号为0
									end
							end
							
					s2	:	begin
								if(row == 4'b1111)			//按键抬起
									begin
										if(cnt_time < 4'd9)	//抬起时没有完成消抖
											begin
												cnt_time <= cnt_time + 4'd1;	//计数器自加一
												flag <= 1'b0;	//标志信号为0
											end
										else						//抬起时完成抖动
											begin
												cnt_time <= 4'd0;	//计数器清零
												flag <= 1'b0;		//标志信号为0
												state <= s0;		//状态停在s0
											end
									end
								else								//按键没有抬起
									begin
										state <= s2;			//状态在s2等待
										cnt_time <= 4'd0;		//计数器为0
										flag <= 1'b0;			//标志信号为0
									end
							end
							
					default	:	state <= s0;				//安全行为
				endcase
			end
	end
	
	/***************对存储的行和列进行编/译码***************/
	always @ (*)
	begin
		if(!rst_n)
			begin
				data = 4'd0;									//初始编码值为0
			end
		else
			begin
				case(row_col)
					8'b1110_1110	:	data = 4'd0;		//"0"
					8'b1110_1101	:	data = 4'd1;		//"1"
					8'b1110_1011	:	data = 4'd2;		//"2"
					8'b1110_0111	:	data = 4'd3;		//"3"
					
					8'b1101_1110	:	data = 4'd4;		//"4"
					8'b1101_1101	:	data = 4'd5;		//"5"
					8'b1101_1011	:	data = 4'd6;		//"6"
					8'b1101_0111	:	data = 4'd7;		//"7"
					
					8'b1011_1110	:	data = 4'd8;		//"8"
					8'b1011_1101	:	data = 4'd9;		//"9"
					8'b1011_1011	:	data = 4'd10;		//"A"
					8'b1011_0111	:	data = 4'd11;		//"b"
					
					8'b0111_1110	:	data = 4'd12;		//"C"
					8'b0111_1101	:	data = 4'd13;		//"d"
					8'b0111_1011	:	data = 4'd14;		//"E"
					8'b0111_0111	:	data = 4'd15;		//"F"
					
					default			:	data = 4'd0;		//"0"
				endcase
			end
	end

endmodule 
