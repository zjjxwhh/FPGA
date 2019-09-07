//分频模块：50MHZ----->1KHZ
module freq(clk, rst_n, clk_1khz);

	input clk;													//系统时钟：50MHZ
	input rst_n;												//系统复位：低电平有效
	
	output reg clk_1khz;										//输出时钟：1KHZ
	
	reg [25:0] cnt;											//定义26位计数器
	
	parameter cnt_num = 50_000_000 / 1000 / 2 - 1;		//0.5ms(下板)
	
	/*******行为建模(时序逻辑)******/
	always @ (posedge clk or negedge rst_n)			//异步复位
	begin
		if(!rst_n)												//复位
			begin
				cnt <= 26'd0;									//计数器清零
				clk_1khz <= 1'b0;								//清零
			end
		else														//置位
			begin
				if(cnt < cnt_num)								//计数器没有计数到0.5ms
					begin
						cnt <= cnt + 26'd1;					//计数器自加一
					end
				else												//计数器计数到0.5ms
					begin
						cnt <= 26'd0;							//计数器清零
						clk_1khz <= ~clk_1khz;					//时钟取反(百分之50占空比,0.5ms高电平,0.5ms低电平)
					end
			end
	end

endmodule 
