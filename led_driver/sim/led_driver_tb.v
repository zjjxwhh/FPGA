`timescale 1ns/1ps
module led_driver_tb;
	
	reg clk;
	reg rst_n;
	
	wire [3:0] led;
	
	led_driver led_driver_inst(
		.clk(clk),
		.rst_n(rst_n),
		.led(led)
	);

	initial
	begin
		clk = 0;
		rst_n = 0;			//先复位
		#200
		rst_n = 1;			//不再处于复位信号	
	end

	always #10 clk = ~clk;		//时钟大小为50MHZ
										//10ns clk电平反转，20ns为一个clk周期，则f=1s/20ns=50mhz

endmodule 