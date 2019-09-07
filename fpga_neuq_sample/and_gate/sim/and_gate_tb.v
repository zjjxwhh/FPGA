`timescale 1ns/1ps			//时间标线
module and_gate_tb;

	reg a;				//输入的信号a
	reg b;				//输入的信号b
	
	wire s;				//输出的信号s

	//端口实例化
	and_gate and_gate_inst(
		.a(a), 
		.b(b), 
		.s(s)
	);
	
	//对所有的输入信号进行初始化数据
	initial
	begin
		a = 0; b = 0;	
		#100				//#代表延时，100代表数值大小，单位为ns
		a = 0; b = 1;
		#100				//#代表延时，100代表数值大小，单位为ns
		a = 1; b = 0;
		#100				//#代表延时，100代表数值大小，单位为ns
		a = 1; b = 1;
		#100
		a = 0; b = 0;
	end

endmodule
