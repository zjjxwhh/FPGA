`timescale 1ns/1ps
module and_gate_behaviour_timing_tb;

	reg clk;
	reg a;
	reg b;
	
	wire s;
	
	//端口实例化
	and_gate_behaviour_timing inst(
		.clk(clk),
		.a(a),
		.b(b),
		.s(s)
	);
	
	//初始化数据
	initial
	begin
		clk = 0;				//时钟刚开始以低电平（0）开始
		a = 1; b = 0;		//初始a=1，b=0
		#17
		a = 0; b = 0;	//延时17ns，a=0，b=0
		#3
		a = 0; b = 1;
		#15
		a = 1; b = 1;
		#5
		a = 1; b = 0;
		#38
		a = 1; b = 1;
		#21
		a = 0; b = 1;
		#17
		a = 0; b = 0;
		#50
		$stop;			//停机（停止波形运行）	
	
	end
	
	always #10 clk = ~clk;	//延时10ns，时钟取反。模拟时钟大小为50MHZ（20ns）
	
endmodule 