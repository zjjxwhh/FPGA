//顶层模块：不做功能描述，只做模块间的连线
module top1(a, b, c, d);

	input a;
	input b;
	input c;
	
	output d;
	
	wire s;			//定义的中间连线信号
	
	//第一次调用与门
	and_gate and_gate_dut1(
		.a(a), 
		.b(b), 
		.s(s)
	);
	
	//第二次调用与门
	and_gate and_gate_dut2(
		.a(s), 
		.b(c), 
		.s(d)
	);

endmodule 
