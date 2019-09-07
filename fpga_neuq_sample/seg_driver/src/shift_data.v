//数据移位模块：每间隔1s实现HELLO循环显示
module shift_data(clk, rst_n, data_out);

	input clk;															//系统时钟：50MHZ
	input rst_n;														//系统复位：低电平有效
	
	output reg [23:0] data_out;									//输出24位移位后的数据

	reg [31:0] cnt;													//定义计数器
	
	parameter cnt_num = 50_000_000 / 1 - 1;	//1s
	
	/*******产生1HZ时钟(1s)*******/
	always @ (posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cnt <= 32'd0;
			end
		else
			begin
				if(cnt < cnt_num)
					cnt <= cnt + 32'd1;
				else
					cnt <= 32'd0;
			end
	end

	wire flag;																//定义1HZ标志信号
		
	assign flag = (cnt == cnt_num) ? 1'b1 : 1'b0;				//三目运算符：if else
	
	//1s标志信号来一次，HELLO移位一次，循环显示
	always @ (posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_out <= 24'h012345;									//HELLO
			end
		else
			begin
				if(flag)														//1s来了
					data_out <= {data_out[3:0],data_out[23:4]};	//右移位
				else															//1s没来
					data_out <= data_out;								//数据保持
			end
	end

endmodule 
