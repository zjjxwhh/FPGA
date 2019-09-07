//Verilog语法规定：
//必须以module开头，以endmodule结尾
//module后面是模块名（和文件名一致），模块名后面是括号
//括号内部是端口定义，外部以分号结尾
module and_gate(a,b,s);

	input a;			//输入信号a
	input b;			//输入信号b
	
	output s;		//输出信号s
	
	//数据流建模（组合逻辑）：描述二输入与门
	assign s = a & b;

endmodule 