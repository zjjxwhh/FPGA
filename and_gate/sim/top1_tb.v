`timescale 1ns/1ps
module top1_tb;

	reg a;				//只需用外部端口
	reg b;
	reg c;
	
	wire d;
	
//	wire s;
//
//	and_gate and_gate_dut1(
//		.a(a),
//		.b(b),
//		.s(s)
//	);
//	
//
//	and_gate and_gate_dut2(
//		.a(s),
//		.b(c),
//		.s(d)
//	);
	
	top1 top1_inst(	//只需用顶层模块
		.a(a),
		.b(b),
		.c(c),
		.d(d)
		);

	initial
	begin
		a = 0; b = 0; c = 0;
		#100
		a = 0; b = 0; c = 1;
		#100
		a = 0; b = 1; c = 0;
		#100
		a = 0; b = 1; c = 1;
		#100
		a = 1; b = 0; c = 0;
		#100
		a = 1; b = 0; c = 1;
		#100
		a = 1; b = 1; c = 0;
		#100
		a = 1; b = 1; c = 1;
		#100
		$stop;
	
	end

endmodule 