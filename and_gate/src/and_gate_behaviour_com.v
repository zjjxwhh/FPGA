module and_gate_behaviour_com(a,b,s);

	input a;
	input b;
	
	output reg s;
	
	//行为建模（组合逻辑）：描述二输入与门
	always @ (a,b)		//电平值：组合逻辑；也可用（*）代替括号中电平值的条件
	begin						//动作用begin...end括起来
		s = a & b;			//凡是在always块，位于赋值号左侧的信号需要定义为reg型
	end
	
endmodule 