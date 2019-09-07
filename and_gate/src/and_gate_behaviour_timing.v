module and_gate_behaviour_timing(clk,a,b,s);

	input clk;
	input a;
	input b;
	
	output reg s;
	
	//行为建模（时序逻辑电路）：描述二输入与门
	always @ (posedge clk)		//以时钟上升沿作为触发条件
	begin
		s <= a & b;					//时序逻辑电路，非阻塞赋值<=
	end
		
endmodule 