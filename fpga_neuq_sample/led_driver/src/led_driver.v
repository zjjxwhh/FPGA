//顶层模块(流水灯)：完成模块间的连线
module led_driver(clk, rst_n, led);

	input clk;				//系统时钟：50MHZ
	input rst_n;			//系统复位：低电平有效
	
	output [3:0] led;		//4个led：低电平点亮
	
	wire clk_1hz;			//定义的中间连线信号
	
	//分频模块：50MHZ--->1HZ
	freq #(.cnt_num(4)) freq_dut(		//强制传参：#(.cnt_num(4))
		.clk(clk), 
		.rst_n(rst_n), 
		.clk_1hz(clk_1hz)
	);
	
	//流水模块：每间隔1s，led流水一次
	led_run led_run_dut(
		.clk_1hz(clk_1hz), 
		.rst_n(rst_n), 
		.led(led)
	);

endmodule 
