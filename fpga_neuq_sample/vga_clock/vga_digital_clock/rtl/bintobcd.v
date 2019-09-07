module bintobcd #(
	parameter	WIDTH_bin	=	6,
	parameter	WIDTH_bcd	=	8
) (
	
	input	wire	[WIDTH_bin - 1 : 0] bin,
	
	output	wire	[WIDTH_bcd - 1 : 0] bcd
);
	
	wire			[WIDTH_bcd + WIDTH_bin - 1 : 0] temp [WIDTH_bin :0];
	
	assign	temp[0] = bin;
	
	genvar 	i;

	generate 
		for (i = 0; i < WIDTH_bin - 1; i = i + 1) 
			begin	:	kkk
				shift_adjust #(
	
							.WIDTH_bin			(WIDTH_bin),
							.WIDTH_bcd			(WIDTH_bcd)
						) shift_adjust_inst(
	
							.idata				(temp[i]),
							
							.odata				(temp[i + 1])
						);
			end
	endgenerate
	
	assign temp[WIDTH_bin] = temp[WIDTH_bin - 1] << 1;
	
	assign bcd = temp[WIDTH_bin][WIDTH_bcd + WIDTH_bin - 1 : WIDTH_bin];
	
endmodule 