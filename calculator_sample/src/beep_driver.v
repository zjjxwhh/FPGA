module beep_driver(clk_1khz, flag, beep);
	input clk_1khz;
	input flag;
	
	parameter beep_cnt_num = 100;
	
	reg [6:0]beep_cnt;
	
	output reg beep;
	
	initial 
	begin
		beep <= 1'b1;
		beep_cnt <= 7'd0;
	end
	
	always @(posedge clk_1khz or posedge flag)
	begin
		if (flag)
			begin
				beep_cnt <= 7'd0;
			end
		else if(beep_cnt < beep_cnt_num)
			begin
				beep <= ~beep;
				beep_cnt <= beep_cnt + 7'd1;
			end
	end

endmodule