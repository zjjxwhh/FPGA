module shift_adjust #(
	
	parameter	WIDTH_bin 	=	20,
	parameter	WIDTH_bcd	=	24
) (
	
	input	wire 	[WIDTH_bcd + WIDTH_bin - 1 : 0] idata,
	
	output	wire	[WIDTH_bcd + WIDTH_bin - 1 : 0] odata
);

	wire			[WIDTH_bcd + WIDTH_bin - 1 : 0] temp;
	
	assign temp = idata << 1;
	
	genvar i;
	
	generate 
		for (i = 0; i < WIDTH_bcd/4; i = i +1)
			begin : jjj
				adjust adjust_inst(

						.idata			(temp[WIDTH_bcd + WIDTH_bin - 1 - 4 *i : WIDTH_bcd + WIDTH_bin - 1 - 3 - 4 * i]),
	
						.odata			(odata[WIDTH_bcd + WIDTH_bin - 1 - 4 *i : WIDTH_bcd + WIDTH_bin - 1 - 3 - 4 * i])
					);
			end
	endgenerate

	assign odata[WIDTH_bin - 1 : 0] = temp[WIDTH_bin - 1 : 0];
	
endmodule 