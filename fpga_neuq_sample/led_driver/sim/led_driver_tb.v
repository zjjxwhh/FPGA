`timescale 1ns/1ps
module led_driver_tb;

	reg clk;					//系统时钟：50MHZ
	reg rst_n;				//系统复位：低电平有效
	
	wire [3:0] led;		//4个led：低电平点亮

	led_driver led_driver_inst(
		.clk(clk), 
		.rst_n(rst_n), 
		.led(led)
	);
	
	initial
	begin
		clk = 0;
		rst_n = 0;				//先复位
		#200
		rst_n = 1;				//不再处于复位信号
	end

	always #10 clk = ~clk;			//时钟大小为50MHZ

endmodule 
