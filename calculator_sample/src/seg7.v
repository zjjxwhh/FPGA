module seg7(clk_1khz,rst_n,data_in,sel,seg);
	
	input clk_1khz;  //输入时钟：1KHZ
	input rst_n;  //系统复位：低电平有效
	input [23:0] data_in;  //输入数据，一个数码管需要4位二进制数据
	
	output reg [2:0] sel;  //数码管位选信号
	output reg [7:0] seg;  //数码管段选信号
	
	/*************************************************/
	reg [2:0] state;  //定义状态寄存器
	reg [3:0] temp;  //接收输入数据其中某四位
	
	`define s0 3'b000  //6个状态的定参,没有分号
	`define s1 3'b001
	`define s2 3'b010
	`define s3 3'b011
	`define s4 3'b100
	`define s5 3'b101

	//时序逻辑，行为建模
	always @ (posedge clk_1khz or negedge rst_n)
	begin
		if(!rst_n)  //复位情况下
			begin
				state <= `s0;
				temp <= 4'd0;
				sel <= 3'd0;  
			end
		else
			begin
				case(state)
					`s0	:	begin
									sel <= 3'd0;  //选择第一个数码管
									temp <= data_in[23:20];  //高四位给到第一个数码管
									state <= `s1;  //状态转移s1
								end
								
					`s1	:	begin
									sel <= 3'd1;  
									temp <= data_in[19:16];  
									state <= `s2;
								end
					
					`s2	:	begin
									sel <= 3'd2;  
									temp <= data_in[15:12];  
									state <= `s3;
								end
								
					`s3	:	begin
									sel <= 3'd3;  
									temp <= data_in[11:8];  
									state <= `s4;
								end
								
					`s4	:	begin
									sel <= 3'd4;  
									temp <= data_in[7:4];  
									state <= `s5;
								end
					
					`s5	:	begin
									sel <= 3'd5;  
									temp <= data_in[3:0];  
									state <= `s0;
								end
					
					default	:	state <= `s0;  //安全行为			
				endcase
			end
	end
	
	//组合逻辑，进行译码
	always @ (*)
	begin
		if(!rst_n)
			begin
				seg = 8'b1100_0000;  //复位时显示0
			end
		else
			begin
				case (temp)
					4'd0	:	seg = 8'b1100_0000;
					4'd1	:	seg = 8'b1111_1001;
					4'd2	:	seg = 8'b1010_0100;
					4'd3	:	seg = 8'b1011_0000;
					 
					4'd4	:	seg = 8'b1001_1001;
					4'd5	:	seg = 8'b1001_0010;
					4'd6	:	seg = 8'b1000_0010;
					4'd7	:	seg = 8'b1111_1000;
					 
					4'd8	:	seg = 8'b1000_0000;
					4'd9	:	seg = 8'b1001_0000;
					
					4'd10	:	seg = 8'b1000_0110;  	//"E"
					4'd11	:	seg = 8'b1010_1111;     //"R"
					4'd12	:	seg = 8'b1010_0011;     //"O"
					
					4'd13	:	seg = 8'b1010_0001;
					4'd14	:	seg = 8'b1000_0110;
					4'd15	:	seg = 8'b1000_1110;
					
					default	:	seg = 8'b1100_0000;
					
				endcase
			end
	end
	
endmodule 