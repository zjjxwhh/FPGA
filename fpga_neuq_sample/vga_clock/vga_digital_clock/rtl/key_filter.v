module key_filter (

	input	wire				clk,
	input	wire				rst_n,
	
	input	wire				key, // low valid
	
	output	reg					key_wave
);

	parameter		T_10ms			=	500_000;
	
	localparam		KEY_OFF			=	4'b0001;
	localparam		ON_SHAKE		=	4'b0010;
	localparam		KEY_ON			=	4'b0100;
	localparam		OFF_SHAKE		=	4'b1000;
	
	reg				[3:0]		c_state;
	reg				[3:0]		n_state;
	reg				[18:0]		cnt;
	reg							key_r;
	reg							key_rr;
	
	always @ (posedge clk) key_r <= key;
	always @ (posedge clk) key_rr <= key_r;
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			c_state <= KEY_OFF;
		else
			c_state <= n_state;
	end
	
	always @ * begin
		case (c_state)
			KEY_OFF			:	if (key_rr == 1'b1)
									n_state = KEY_OFF;
								else
									n_state = ON_SHAKE;
			
			ON_SHAKE		:	if (key_rr == 1'b1)
									n_state = KEY_OFF;
								else
									if (cnt >= T_10ms - 1'b1)
										n_state = KEY_ON;
									else
										n_state = ON_SHAKE;
										
			KEY_ON			:	if (key_rr == 1'b0)
									n_state = KEY_ON;
								else
									n_state = OFF_SHAKE;
							
			OFF_SHAKE		:	if (key_rr == 1'b0)
									n_state = KEY_ON;
								else
									if (cnt >= T_10ms - 1'b1)
										n_state = KEY_OFF;
									else
										n_state = OFF_SHAKE;
			
			default			:	n_state = KEY_OFF;
		endcase
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			cnt <= 19'd0;
		else
			case (c_state)
				KEY_OFF			:	cnt <= 19'd0;
				ON_SHAKE		:	if (key_rr == 1'b1)
										cnt <= 19'd0;
									else
										if (cnt < T_10ms - 1'b1)
											cnt <= cnt + 1'b1;
										else
											cnt <= 19'd0;
				KEY_ON			:	cnt <= 19'd0;
				OFF_SHAKE		:	if (key_rr == 1'b0)
										cnt <= 19'd0;
									else
										if (cnt < T_10ms - 1'b1)
											cnt <= cnt + 1'b1;
										else
											cnt <= 19'd0;
				default			:	cnt <= 19'd0;
			endcase
	end

	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			key_wave <= 1'b1;
		else
			case (c_state)
				KEY_OFF		:	key_wave <= 1'b1;
				ON_SHAKE	:	key_wave <= 1'b1;
				KEY_ON		:	key_wave <= 1'b0;
				OFF_SHAKE	:	key_wave <= 1'b0;
				default		:	key_wave <= 1'b1;
			endcase
	end
	
endmodule 