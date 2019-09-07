//分频模块：50MHZ---->1HZ
module freq(clk,rst_n,clk_1hz);

	input clk;				//系统时钟：50MHZ
	input rst_n;			//系统复位：低电平有效
	
	output reg clk_1hz;		//输出时钟：1HZ
	
	reg [25:0] cnt;		//定义26位计数器
	
	parameter cnt_num = 50_000_000 / 1 / 2 - 1;		//0.5s；从0开始计数，计到50_000_000/2-1时为0.5s
	
	//行为建模（时序逻辑）
	always @ (posedge clk or negedge rst_n)	//异步复位
	begin
		if(!rst_n)			//复位
			begin
				cnt <= 26'd0;							//26：位宽；d：十进制；0：数字0
				clk_1hz <= 1'b0;						//1：位宽；b：二进制；0：数字0
			end
		else					//置位
			begin
				if(cnt < cnt_num)						//计数器没有计数到0.5s
					begin
						cnt <= cnt + 26'd1;			//计数器自加一
					end
				else										//计数器计数到0.5s
					begin
						cnt <= 26'd0;					//计数器清零
						clk_1hz <= ~clk_1hz;			//时钟取反（50%占空比，0.5s高电平，0.5s低电平）
					end
			end	
	end

endmodule 