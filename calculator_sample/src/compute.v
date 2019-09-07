//计算模块的表示
module compute(clk, rst_n, flag, press_num, data_out);
	
	input clk;
	input rst_n;
	input flag;
	
	input  [3:0] press_num;
	
	output reg [23:0] data_out;
	
//	/********************分频***********************/
//	reg [19:0] cnt;  //计数器
//	reg clk_1khz;
//	
//	parameter cnt_num = 50_000_000 / 1000 / 2 - 1;  //0.5ms
//	
//	always @ (posedge clk or negedge rst_n)
//	begin
//		if(!rst_n)
//			begin
//				cnt <= 20'd0;  //计数器清零
//				clk_1khz <= 1'b0;  //1khz信号清零
//			end
//		else
//			begin
//				if(cnt < cnt_num)  //计数器没有到0.5ms
//					begin
//						cnt = cnt +20'd1;  //计数器自加一
//					end
//				else              //计数器计数到0.5ms
//					begin
//						clk_1khz = ~clk_1khz;  
//						cnt <= 20'd0;
//					end
//			end
//	end

	
	
	`define a0 2'b00				//定参
   `define a1 2'b01
   `define a2 2'b10
	`define a3 2'b11
	
	reg [1:0] state_s;   //状态变量
	reg [23:0] num1,num2,data_in,data_t,num3;	//信号变量
	reg [3:0] flag_s;    //运算符
	reg flag_t;				//运算结束标志位
	reg flag_o;				//运算溢出标志位
	
	always @ (posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				begin
					data_out <= 24'b0;
					state_s <= `a0;
					num1 <= 24'b0;
					num2 <= 24'b0; 
					num3 <= 24'b0; 
					data_t <= 24'b0;
					flag_s <= 4'b0;
					data_in <= 24'b0;
					flag_t <= 1'd0;
					flag_o <= 1'd0;
				end
			else
				begin
					case (state_s)
						`a0:begin
								if(flag)	//如果有一次按下
									begin
										if(press_num <= 4'd9)  //键值小于或等于9便是有效
											begin
												if(flag_t == 1)
													begin
														flag_t <= 1'd0;
														data_out [23:0] <= press_num;
														num1 <= press_num;  //使结果变成多位													
														state_s <= `a0;
													end
												else
													begin
														num1 <= num1*10 + press_num;  //使结果变成多位
														data_out <= {data_out[19:0],press_num};  //数码管移位
														state_s <= `a0;
													end
											end
										if(press_num > 4'd9 && press_num < 4'd14) //10 -- 13 表示运算符
											begin
												if(flag_t == 1)
													begin
														num1 <= num3;
														data_out <= 24'b0;
														state_s <= `a1;
														flag_s <= press_num;
														flag_t <= 1'd0;
													end
												else
													begin
														data_out <= 24'b0;
														state_s <= `a1;
														flag_s <= press_num;
													end
											end
										else if(press_num == 14)
													begin
														data_out  <= 24'b0;
														state_s <= `a0;
														num1 <= 24'b0;
														num2 <= 24'b0; 
														num3 <= 24'b0;
														flag_s <= 4'b0;
														data_in <= 24'b0;
													end
										else   //否则无效信号
											state_s <= `a0;
									end
								else
									begin
										state_s <= `a0;
									end
							end
						`a1:begin
								if(flag)//如果有一次按下
				 				begin
									if(press_num <= 4'd9 )  //键值小于或等于9便是有效
										begin
											num2 <= 10*num2 +press_num;//使结果变成多位
											data_out <= {data_out[19:0],press_num};//数码管移位
											state_s <= `a1;
										end
									if(press_num > 4'd9 && press_num < 4'd14)//10 -- 13 表示运算符
											begin
												state_s <= `a1;
												flag_s <= press_num;
											end	
									if(press_num == 15) //表示等于
										begin		
											state_s <= `a2;
										end
								end		
							end
						`a2:begin
								state_s <= `a3;
								case (flag_s)	
									4'd10 :	begin  //加运算
													data_in <= num1 + num2; 
													if((num1 + num2)>24'd999999)
														begin
															flag_o = 1;	
														end
													else
														begin
															num3 <= num1 + num2;
														end
													state_s <= `a3;
												end
								
									4'd11 :	begin  //减运算
													data_in <= num1 - num2;
													if(num1 < num2)
														begin
															flag_o = 1;
														end
													else
														begin
															num3 <= num1 - num2;
														end
													state_s <= `a3;
												end
									
									4'd12 :	begin  //乘运算
													data_in <= num1 * num2;
													if((num1 * num2)>24'd999999)
														begin
															flag_o = 1;
														end
													else
														begin
															num3 <= num1 * num2;
														end
													state_s <= `a3;
												end
									9k'k'k'k'k'k'k'k'k'k'k'k'k'k'k'k'k'k'k
									4'd13 :	begin  //除运算
													data_in <= 2 ** (num1+num2);
													if(num2 == 0)
														begin
															flag_o = 1;
														end
													else
														begin
															num3 <= num1 / num2;
														end
													state_s <= `a3;
												end
								endcase
							end
						`a3:begin    //二进制转为BCD码显示到对应的数码管上
								if(flag_o == 1)
									begin
										data_out[23:20] = 1'h0;
										data_out[19:16] = 4'd10;
										data_out[15:12] = 4'd11;
										data_out[11:8]  = 4'd11;
										data_out[7:4]   = 4'd12;
										data_out[3:0]   = 4'd11;
										
										state_s <= `a0;
										data_in <= 24'b0;
										num1 <= 24'b0;
										num2 <= 24'b0;
										flag_t <= 1'd1;
										
										flag_o = 0;
									end
								else
								begin
									data_out[3:0] = data_in % 10;
									data_out[7:4] = data_in / 10 % 10;
									data_out[11:8] = data_in / 100 % 10;	
									data_out[15:12] = data_in / 1000 % 10;
									data_out[19:16] = data_in / 10000 % 10;
									data_out[23:20] = data_in / 100000;
									
									flag_t <= 1'b1;
									state_s <= `a0;
									data_in <= 24'b0;
									num1 <= 24'b0;
									num2 <= 24'b0;

								end		
							end
						default: state_s <= `a0;
					endcase
				end
		end
		
endmodule 