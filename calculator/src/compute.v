module compute(clk, rst_n, data_in, flag, data_out);
	input clk;
	input rst_n;
	input [3:0] data_in;
	input flag;
	
	output reg [23:0] data_out;
	
	reg [23:0] data_temp;
	reg [2:0] state;
	reg [23:0] num1;
	reg [23:0] num2;
	reg [3:0] operate1;
	reg [3:0] operate2;
	reg zero;
	
	`define s0 3'b000
	`define s1 3'b001
	`define s2 3'b010
	`define s3 3'b011
	
	always @	(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_temp <= 24'd0;
				data_out <= 24'd0;
				state <= `s0;
				num1 <= 24'd0;
				num2 <= 24'd0;
				operate1 <= 3'd0;
				operate2 <= 3'd0;
			end
		else
			begin
				case(state)
					`s0	:	begin
									if(flag)
										begin
											if(data_in < 4'd10)
												begin 
													num1 <= num1 * 10 + data_in;
													data_out <= {data_out[19:0],data_in};
												end
											else if(data_in > 4'd9 && data_in < 4'd14)
												begin
													data_out <= 24'b0;
													operate1 <= data_in;
													state <= `s1;
												end
											else 
												begin
													state <= `s0;
												end
										end
								end
					`s1	:	begin
									if(flag)
										begin
											if(data_in < 4'd10)
												begin
													num2 <= 10 * num2 + data_in;
													data_out <= {data_out[19:0],data_in};
												end
											else if(data_in > 4'd9 && data_in < 4'd15)
												begin
													operate2 <= data_in;
													state <= `s2;
												end
										end
								end
								
					`s2	:	begin
									case(operate1)
										4'd10	:	begin
														data_temp <= num1 + num2;
														state <= `s3;
													end
										
										4'd11	:	begin
														data_temp <= num1 - num2;
														state <= `s3;
													end
										
										4'd12	:	begin
														data_temp <= num1 * num2;
														state <= `s3;
													end
										
										4'd13	:	begin
														data_temp <= num1 / num2;
														state <= `s3;
													end
									endcase
								end
						
					`s3	:	begin
									data_out[3:0] <= data_temp % 10;
									data_out[7:4] <= data_temp / 10 % 10;
									data_out[11:8] <= data_temp / 100 % 10;
									data_out[15:12] <= data_temp / 1000 % 10;
									data_out[19:16] <= data_temp / 10000 % 10;
									data_out[23:20] <= data_temp / 100000 % 10;
									if(operate2 > 4'd9 && operate2 < 4'd14)
										begin
											num1 <= data_temp;
											operate1 <= operate2;
											num2 <= 24'd0;
											operate2 <= 24'd0;
											data_out <= 24'd0;
											state <= `s1;
										end
								end
				endcase
			end
	
	end

endmodule 