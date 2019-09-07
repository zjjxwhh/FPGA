//流水模块：每间隔1s，led灯流水一次，循环显示
module led_run(clk_1hz, rst_n, led);

	input clk_1hz;												//输入时钟：1HZ
	input rst_n;												//系统复位：低电平有效

	output reg [3:0] led;									//4个led：低电平点亮
	
	always @ (posedge clk_1hz or negedge rst_n)
	begin
		if(!rst_n)
			begin
				led <= 4'b0111;								//最高位灯点亮
			end
		else
			begin
				led <= {led[0],led[3:1]};					//右移位
			end
	end

//	reg [1:0] state;											//状态寄存器
//
//	`define s0 2'b00											//定参(全局参数)
//	`define s1 2'b01
//	`define s2 2'b10
//	`define s3 2'b11
//	
//	/*******行为建模(时序逻辑)*******/
//	always @ (posedge clk_1hz or negedge rst_n)		//异步复位
//	begin
//		if(!rst_n)												//复位
//			begin
//				state <= `s0;									//状态停在s0
//				led <= 4'b0;									//4个led灯全亮
//			end
//		else														//置位
//			begin
//				case(state)										//状态机结构描述
//					`s0	:	begin
//									led <= 4'b0111;			//最高位灯点亮
//									state <= `s1;				//状态跳转s1
//								end
//								
//					`s1	:	begin
//									led <= 4'b1011;			//次高位灯点亮
//									state <= `s2;				//状态跳转s2
//								end
//								
//					`s2	:	begin
//									led <= 4'b1101;			//次低位灯点亮
//									state <= `s3;				//状态跳转s3
//								end
//								
//					`s3	:	begin
//									led <= 4'b1110;			//最低位灯点亮
//									state <= `s0;				//状态跳转s0
//								end
//					
//					default	:	state <= `s0;				//安全行为（其他情况状态停在s0）
//				endcase
//			end
//	end

endmodule 
