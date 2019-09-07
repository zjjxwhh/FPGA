//数码管驱动模块
module seg7(clk_1khz, rst_n, data_in, sel, seg);

	input clk_1khz;									//数码管位选切换频率：1KHZ
	input rst_n;										//系统复位：低电平有效
	input [23:0] data_in;							//输入的24位数据(一个数码管需要4位二进制数)
	
	output reg [2:0] sel;							//数码管位选信号
	output reg [7:0] seg;							//数码管段选信号
	
	reg [2:0] state;									//定义的状态寄存器
	reg [3:0] temp;									//定义的4位中间寄存器
	
	`define s0 3'b000									//定参
	`define s1 3'b001
	`define s2 3'b010
	`define s3 3'b011
	`define s4 3'b100
	`define s5 3'b101
	
	/************行为建模(时序逻辑电路)***************/
	always @ (posedge clk_1khz or negedge rst_n)
	begin
		if(!rst_n)
			begin
				state <= `s0;										//状态停在s0状态
				sel <= 3'd0;										//选择第一个数码管
				temp <= 4'd0;										//中间寄存器清零
			end
		else
			begin
				case(state)											//状态机结构描述
					`s0	:	begin
									sel <= 3'd0;					//选择第一个数码管
									temp <= data_in[23:20];		//选择高四位数码管给到这个数码管
									state <= `s1;					//状态跳转s1
								end
								
					`s1	:	begin
									sel <= 3'd1;					//选择第二个数码管
									temp <= data_in[19:16];		//选择接下来四位数据给到这个数码管
									state <= `s2;					//状态跳转s2
								end
								
					`s2	:	begin
									sel <= 3'd2;					//选择第三个数码管
									temp <= data_in[15:12];		//选择接下来四位数据给到这个数码管
									state <= `s3;					//状态跳转s3
								end
								
					`s3	:	begin
									sel <= 3'd3;					//选择第四个数码管
									temp <= data_in[11:8];		//选择接下来四位数据给到这个数码管
									state <= `s4;					//状态跳转s4
								end
								
					`s4	:	begin
									sel <= 3'd4;					//选择第五个数码管
									temp <= data_in[7:4];		//选择接下来四位数据给到这个数码管
									state <= `s5;					//状态跳转s5
								end
								
					`s5	:	begin
									sel <= 3'd5;					//选择第六个数码管
									temp <= data_in[3:0];		//选择最后四位数据给到这个数码管
									state <= `s0;					//状态跳转s0
								end
								
					default	:	state <= `s0;					//安全行为
				endcase
			end
	end
	
	//行为建模(组合逻辑电路):对数码管进行译码
	always @ (*)
	begin
		if(!rst_n)
			begin
				seg = 8'b1100_0000;								//显示"0"
			end
		else
			begin
				case(temp)
					4'd0		:		seg = 8'b1100_0000;		//"0"
					4'd1		:		seg = 8'b1111_1001;		//"1"
					4'd2		:		seg = 8'b1010_0100;		//"2"
					4'd3		:		seg = 8'b1011_0000;		//"3"
					
					4'd4		:		seg = 8'b1001_1001;		//"4"
					4'd5		:		seg = 8'b1001_0010;		//"5"
					4'd6		:		seg = 8'b1000_0010;		//"6"
					4'd7		:		seg = 8'b1111_1000;		//"7"
					
					4'd8		:		seg = 8'b1000_0000;		//"8"
					4'd9		:		seg = 8'b1001_0000;		//"9"
					4'd10		:		seg = 8'b1000_1000;		//"A"
					4'd11		:		seg = 8'b1000_0011;		//"b"
					
					4'd12		:		seg = 8'b1100_0110;		//"C"
					4'd13		:		seg = 8'b1010_0001;		//"d"
					4'd14		:		seg = 8'b1000_0110;		//"E"
					4'd15		:		seg = 8'b1000_1110;		//"F"
					
					default	:	seg = 8'b1100_0000;
				endcase
			end
	end
	
endmodule 
