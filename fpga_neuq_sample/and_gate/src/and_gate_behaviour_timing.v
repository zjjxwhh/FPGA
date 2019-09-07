module and_gate_behaviour_timing(clk, a, b, s);

	input clk;
	input a;
	input b;
	
	output reg s;

	//行为建模（时序逻辑电路）：描述二输入与门
	always @ (posedge clk)		//以时钟上升沿作为触发条件
	begin
		s <= a & b;	//凡是在always块，位于赋值号左侧的信号需要定义为reg型
	end

endmodule 
