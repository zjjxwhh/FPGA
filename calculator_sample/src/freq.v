//分频模块
module freq(clk,rst_n,clk_1khz);

	input clk;  //系统时钟：50MHZ
	input rst_n;  //系统复位：低电平有效
	
	output reg clk_1khz;  //目标时钟：1KHZ
	
	reg [25:0] cnt;  //定义计数器
	
	parameter cnt_num = 50_000_000 / 1000 / 2 - 1;  //0.5ms
	
	/*******行为建模（时序逻辑）********/
	always @ (posedge clk or negedge rst_n)  //异步复位
	begin  //语句并行实行，逻辑顺序实行，always块之间并行实行
		if(!rst_n) //高电平
			begin
				cnt <= 26'd0;  //计数器清零
				clk_1khz <= 1'b0;  //时钟初始以低电平开始
			end
		else
			begin
				if(cnt < cnt_num)  //计数器没有计数到0.5ms
				begin
					cnt <= cnt + 26'd1;  //计数器自加一
				end
				else             //计数器没有计数到0.5ms
				begin
					cnt <= 26'd0;  //计数器清零
					clk_1khz <= ~clk_1khz;  //时钟取反（0.5ms高，0.5ms低）
				end
			end
	end
	
	
	
endmodule 