//二进制转BCD模块：将输入的二进制数转换成BCD码
module bin_bcd(bin, bcd);

	inout [7:0] bin;						//输入的8位二进制数
	
	output reg [7:0] bcd;				//输出的8位BCD码
	
	//行为建模（组合逻辑）
	always @(*)
	begin
		bcd[3:0] = bin % 10;				//个位
		bcd[7:4] = bin / 10 %10;		//十位
	end
	
//	assign bcd[3:0] = bin % 10;
//	assign bce[7:4] = bin / 10 % 10;
	
endmodule 