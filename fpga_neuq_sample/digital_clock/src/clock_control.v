//数字钟逻辑控制模块
module clock_control(clk, rst_n, data_out);
	
	input clk;												//系统时钟：50MHZ
	input rst_n;											//系统复位：低电平有效
	
	output reg [23:0] data_out;						//输出24位数据

	/********产生一个1HZ时钟(1s)**********/
	reg [31:0] cnt;										//定义计数器
	reg clk_1hz;											//定义时钟
	
	parameter cnt_num = 50_000_000 / 1 / 2 - 1;	//0.5s
	
	always @ (posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cnt <= 32'd0;								//计数器清零
				clk_1hz <= 1'b0;							//时钟信号为0
			end
		else
			begin
				if(cnt < cnt_num)							//计数器没有计数到0.5s
					begin
						cnt <= cnt + 32'd1;				//计数器自加一
					end
				else											//计数器计数到0.5s
					begin
						cnt <= 32'd0;						//计数器清零
						clk_1hz <= ~clk_1hz;				//时钟取反(1s)
					end
			end
	end
	
	/*************数字钟逻辑实现*****************/
	always @ (posedge clk_1hz or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_out <= 24'h0;						//设置数字钟的初始时间：00:00:00
			end
		else
			begin
				if(data_out == 24'h173B3B)				//23:59:59
					data_out <= 24'h0;					//00:00:00
				else if(data_out[15:0] == 16'h3B3B)	//XX:59:59
					begin
						data_out[23:16] <= data_out[23:16] + 8'd1;	//小时加一
						data_out[15:0] <= 16'h0;		//秒和分清零			
					end
				else if(data_out[7:0] == 8'h3B)		//XX:XX:59
					begin
						data_out[15:8] <= data_out[15:8] + 8'd1;	//分钟自加一
						data_out[7:0] <= 8'h0;			//秒清零
					end
				else											//在0-59秒范围内
					data_out[7:0] <= data_out[7:0] + 8'd1;	//秒自加一 
			end
	end
	
endmodule 
