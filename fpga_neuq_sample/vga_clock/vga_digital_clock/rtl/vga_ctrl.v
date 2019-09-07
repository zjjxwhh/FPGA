module vga_ctrl (

	input	  wire					  clk,
	input	  wire					  rst_n,
	input  [7:0]q,

	output reg [14:0]adrrp,
	output	reg						  vga_hs,
	output	reg						  vga_vs,
	output	reg			[7:0]		vga_rgb,
	
	output	reg			[7:0]	  addr,
	output  reg     [2:0]   sel,
	input		wire 		[7:0]		rom_data
);
	
	localparam		HS_A		=	96;
	localparam		HS_B		=	48;
	localparam		HS_C		=	640;
	localparam		HS_D		=	16;
	localparam		HS_E		=	800;
	
	localparam		VS_A		=	2;
	localparam		VS_B		=	33;
	localparam		VS_C		=	480;
	localparam		VS_D		=	10;
	localparam		VS_E		=	525;
	
	reg					[9:0]		cnt_hs;
	reg					[9:0]		cnt_vs;
	reg    flag;
	
	reg         [10:0]   addr_0;     
	reg         [10:0]   addr_1;
	reg         [10:0]   addr_2;
	reg         [10:0]   addr_3;
	reg         [10:0]   addr_4;
	reg         [10:0]   addr_5;
	reg         [10:0]   addr_6;
	reg         [10:0]   addr_7;
	
	reg                  addr0_hs_en;      //时高位使能
	reg                  addr1_hs_en;
	reg                  addr2_hs_en;
	reg                  addr3_hs_en;
	reg                  addr4_hs_en;
	reg                  addr5_hs_en;
	reg                  addr6_hs_en;
	reg                  addr7_hs_en;
	
	reg                  addr_vs_en;
	
	reg                  data0_en;
	reg                  data1_en;
	reg                  data2_en;
	reg                  data3_en;
	reg                  data4_en;
	reg                  data5_en;
	reg                  data6_en;
	reg                  data7_en;
	
	reg                  addr0_en_r;
	reg                  addr0_en_rr;
	reg                  addr0_en_rrr;
	reg                  addr0_en_rrrr;
	reg                  addr1_en_r;
	reg                  addr1_en_rr;
	reg                  addr1_en_rrr;
	reg                  addr1_en_rrrr;
	reg                  addr2_en_r;
	reg                  addr2_en_rr;
	reg                  addr2_en_rrr;
	reg                  addr2_en_rrrr;
	reg                  addr3_en_r;
	reg                  addr3_en_rr;
	reg                  addr3_en_rrr;
	reg                  addr3_en_rrrr;
	reg                  addr4_en_r;
	reg                  addr4_en_rr;
	reg                  addr4_en_rrr;
	reg                  addr4_en_rrrr;
	reg                  addr5_en_r;
	reg                  addr5_en_rr;
	reg                  addr5_en_rrr;
	reg                  addr5_en_rrrr;
	reg                  addr6_en_r;
	reg                  addr6_en_rr;
	reg                  addr6_en_rrr;
	reg                  addr6_en_rrrr;
	reg                  addr7_en_r;
	reg                  addr7_en_rr;
	reg                  addr7_en_rrr;
	reg                  addr7_en_rrrr;
	
	
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			cnt_hs <= 0;
		else
			if (cnt_hs < HS_E - 1)
				cnt_hs <= cnt_hs + 1'b1;
			else	
				cnt_hs <= 0;
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			vga_hs <= 1;
		else	
			if (cnt_hs < HS_A)
				vga_hs <= 0;
			else
				vga_hs <= 1;
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			cnt_vs <= 0;
		else
			if (cnt_hs == HS_E - 1)
				if (cnt_vs < VS_E - 1)
					cnt_vs <= cnt_vs + 1'b1;
				else	
					cnt_vs <= 0;
			else
				cnt_vs <= cnt_vs;
	end
	
	always @ (posedge clk, negedge rst_n) begin 
		if (rst_n == 0)
			vga_vs <= 1;
		else	
			if (cnt_vs < VS_A)
				vga_vs <= 0;
			else
				vga_vs <= 1;
	end
	
	//图片画框
	
//	always @ (*) begin 
//		if (rst_n == 0)
//			flag <= 0;
//		else	
//			if ((cnt_vs >= VS_A + VS_B + 79) && (cnt_vs < VS_A + VS_B + 229) && (cnt_hs > HS_A + HS_B - 1 + 245) && (cnt_hs < HS_A + HS_B + 150 + 245))
//				flag <= 1;
//			else
//				flag <= 0;
//	end
	
	//图片填充
	/*
	always @ (posedge clk, negedge rst_n) begin 
		if (rst_n == 0)
			begin 
				vga_rgb <= 8'b0;
				adrrp <= 15'd0;
			end 
		else	
			if(flag)begin
				if (adrrp<22500)
					begin
						adrrp <= adrrp + 1;
						vga_rgb <= q;
					end 
				else
					adrrp <= 15'd0;
			end 
	end
	*/
/*	
	wire addr0_hs_en = (cnt_hs > HS_A + HS_B - 1) && (cnt_hs < HS_A + HS_B + 32);
	wire addr0_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr0_en = addr0_hs_en & addr0_vs_en;
	
	wire data0_hs_en = (cnt_hs > HS_A + HS_B + 2) && (cnt_hs < HS_A + HS_B + 35);
	wire data0_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data0_en = data0_hs_en & data0_vs_en;
	
	wire addr1_hs_en = (cnt_hs > HS_A + HS_B + 39) && (cnt_hs < HS_A + HS_B + 72);
	wire addr1_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr1_en = addr1_hs_en & addr1_vs_en;
	
	wire data1_hs_en = (cnt_hs > HS_A + HS_B + 42) && (cnt_hs < HS_A + HS_B + 75);
	wire data1_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data1_en = data1_hs_en & data1_vs_en;
	
	wire addr2_hs_en = (cnt_hs > HS_A + HS_B + 79) && (cnt_hs < HS_A + HS_B + 112);
	wire addr2_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr2_en = addr2_hs_en & addr2_vs_en;
	
	wire data2_hs_en = (cnt_hs > HS_A + HS_B + 82) && (cnt_hs < HS_A + HS_B + 115);
	wire data2_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data2_en = data2_hs_en & data2_vs_en;
	
	wire addr3_hs_en = (cnt_hs > HS_A + HS_B + 119) && (cnt_hs < HS_A + HS_B + 152);
	wire addr3_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr3_en = addr3_hs_en & addr3_vs_en;
	
	wire data3_hs_en = (cnt_hs > HS_A + HS_B + 122) && (cnt_hs < HS_A + HS_B + 155);
	wire data3_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data3_en = data3_hs_en & data3_vs_en;
	
	wire addr4_hs_en = (cnt_hs > HS_A + HS_B + 159) && (cnt_hs < HS_A + HS_B + 192);
	wire addr4_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr4_en = addr4_hs_en & addr4_vs_en;
	
	wire data4_hs_en = (cnt_hs > HS_A + HS_B + 162) && (cnt_hs < HS_A + HS_B + 195);
	wire data4_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data4_en = data4_hs_en & data4_vs_en;
	
	wire addr5_hs_en = (cnt_hs > HS_A + HS_B + 199) && (cnt_hs < HS_A + HS_B + 232);
	wire addr5_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr5_en = addr5_hs_en & addr5_vs_en;
	
	wire data5_hs_en = (cnt_hs > HS_A + HS_B + 202) && (cnt_hs < HS_A + HS_B + 235);
	wire data5_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data5_en = data5_hs_en & data5_vs_en;
	
	wire addr6_hs_en = (cnt_hs > HS_A + HS_B + 239) && (cnt_hs < HS_A + HS_B + 272);
	wire addr6_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr6_en = addr6_hs_en & addr6_vs_en;
	
	wire data6_hs_en = (cnt_hs > HS_A + HS_B + 242) && (cnt_hs < HS_A + HS_B + 275);
	wire data6_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data6_en = data6_hs_en & data6_vs_en;
	
	wire addr7_hs_en = (cnt_hs > HS_A + HS_B + 279) && (cnt_hs < HS_A + HS_B + 312);
	wire addr7_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire addr7_en = addr7_hs_en & addr7_vs_en;
	
	wire data7_hs_en = (cnt_hs > HS_A + HS_B + 282) && (cnt_hs < HS_A + HS_B + 315);
	wire data7_vs_en = (cnt_vs > VS_A + VS_B - 1 + 50) && (cnt_vs < VS_A + VS_B + 64 + 50);
	wire data7_en = data7_hs_en & data7_vs_en;
	
*/
	//数字钟显示时所有行的区域（50-113），共占据64行
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr_vs_en <= 1'b0;
    else
      addr_vs_en <=  (cnt_vs > VS_A + VS_B - 1 + 208 + 100) && (cnt_vs < VS_A + VS_B + 64 + 208 + 100);
  end
  
  //数字钟显示时每个时刻所占据列数为34，每个时刻间距为8
  //hour_high
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr0_hs_en <= 1'b0;
    else
      addr0_hs_en <= (cnt_hs > HS_A + HS_B - 1 + 156) && (cnt_hs < HS_A + HS_B + 32 + 156);
  end	
  
  //hour_low
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr1_hs_en <= 1'b0;
    else
      addr1_hs_en <= (cnt_hs > HS_A + HS_B + 39 + 156) && (cnt_hs < HS_A + HS_B + 72 + 156);
  end	
  
  //:
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr2_hs_en <= 1'b0;
    else
      addr2_hs_en <= (cnt_hs > HS_A + HS_B + 79 + 156) && (cnt_hs < HS_A + HS_B + 112 + 156);
  end	
  
  //min_high
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr3_hs_en <= 1'b0;
    else
      addr3_hs_en <= (cnt_hs > HS_A + HS_B + 119 + 156) && (cnt_hs < HS_A + HS_B + 152 + 156);
  end	
  
  //min_low
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr4_hs_en <= 1'b0;
    else
      addr4_hs_en <= (cnt_hs > HS_A + HS_B + 159 +156) && (cnt_hs < HS_A + HS_B + 192 +156);
  end	
  
  //:
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr5_hs_en <= 1'b0;
    else
      addr5_hs_en <= (cnt_hs > HS_A + HS_B + 199 + 156) && (cnt_hs < HS_A + HS_B + 232 + 156);
  end	
  
  //sec_high
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr6_hs_en <= 1'b0;
    else
      addr6_hs_en <= (cnt_hs > HS_A + HS_B + 239 + 156) && (cnt_hs < HS_A + HS_B + 272 + 156);
  end	
  
  //sec_low
  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr7_hs_en <= 1'b0;
    else
      addr7_hs_en <= (cnt_hs > HS_A + HS_B + 279 + 156) && (cnt_hs < HS_A + HS_B + 312 + 156);
  end	
  
  wire addr0_en = addr0_hs_en & addr_vs_en;
  wire addr1_en = addr1_hs_en & addr_vs_en;	
  wire addr2_en = addr2_hs_en & addr_vs_en;
  wire addr3_en = addr3_hs_en & addr_vs_en;	
  wire addr4_en = addr4_hs_en & addr_vs_en;
  wire addr5_en = addr5_hs_en & addr_vs_en;	
  wire addr6_en = addr6_hs_en & addr_vs_en;
  wire addr7_en = addr7_hs_en & addr_vs_en;	
  
  always @ (posedge clk) addr0_en_r <= addr0_en;
  always @ (posedge clk) addr0_en_rr <= addr0_en_r;
  always @ (posedge clk) addr0_en_rrr <= addr0_en_rr;
  always @ (posedge clk) addr0_en_rrrr <= addr0_en_rrr;
  always @ (posedge clk) data0_en <= addr0_en_rrr;
  
  always @ (posedge clk) addr1_en_r <= addr1_en;
  always @ (posedge clk) addr1_en_rr <= addr1_en_r;
  always @ (posedge clk) addr1_en_rrr <= addr1_en_rr;
  always @ (posedge clk) addr1_en_rrrr <= addr1_en_rrr;
  always @ (posedge clk) data1_en <= addr1_en_rrr;
  
  always @ (posedge clk) addr2_en_r <= addr2_en;
  always @ (posedge clk) addr2_en_rr <= addr2_en_r;
  always @ (posedge clk) addr2_en_rrr <= addr2_en_rr;
  always @ (posedge clk) addr2_en_rrrr <= addr2_en_rrr;
  always @ (posedge clk) data2_en <= addr2_en_rrr;
  
  always @ (posedge clk) addr3_en_r <= addr3_en;
  always @ (posedge clk) addr3_en_rr <= addr3_en_r;
  always @ (posedge clk) addr3_en_rrr <= addr3_en_rr;
  always @ (posedge clk) addr3_en_rrrr <= addr3_en_rrr;
  always @ (posedge clk) data3_en <= addr3_en_rrr;
  
  always @ (posedge clk) addr4_en_r <= addr4_en;
  always @ (posedge clk) addr4_en_rr <= addr4_en_r;
  always @ (posedge clk) addr4_en_rrr <= addr4_en_rr;
  always @ (posedge clk) addr4_en_rrrr <= addr4_en_rrr;
  always @ (posedge clk) data4_en <= addr4_en_rrr;
  
  always @ (posedge clk) addr5_en_r <= addr5_en;
  always @ (posedge clk) addr5_en_rr <= addr5_en_r;
  always @ (posedge clk) addr5_en_rrr <= addr5_en_rr;
  always @ (posedge clk) addr5_en_rrrr <= addr5_en_rrr;
  always @ (posedge clk) data5_en <= addr5_en_rrr;
  
  always @ (posedge clk) addr6_en_r <= addr6_en;
  always @ (posedge clk) addr6_en_rr <= addr6_en_r;
  always @ (posedge clk) addr6_en_rrr <= addr6_en_rr;
  always @ (posedge clk) addr6_en_rrrr <= addr6_en_rrr;
  always @ (posedge clk) data6_en <= addr6_en_rrr;
  
  always @ (posedge clk) addr7_en_r <= addr7_en;
  always @ (posedge clk) addr7_en_rr <= addr7_en_r;
  always @ (posedge clk) addr7_en_rrr <= addr7_en_rr;
  always @ (posedge clk) addr7_en_rrrr <= addr7_en_rrr;
  always @ (posedge clk) data7_en <= addr7_en_rrr;
  
	always @ (posedge clk) begin
    if (rst_n == 1'b0) 
      sel <= 3'd0;
    else
      if (addr0_en == 1'b1)
        sel <= 3'd0;
      if (addr1_en == 1'b1)
        sel <= 3'd1;
      if (addr2_en == 1'b1)
        sel <= 3'd2;
      if (addr3_en == 1'b1)
        sel <= 3'd3;
      if (addr4_en == 1'b1)
        sel <= 3'd4;
      if (addr5_en == 1'b1)
        sel <= 3'd5;
      if (addr6_en == 1'b1)
        sel <= 3'd6;
      if (addr7_en == 1'b1)
        sel <= 3'd7;
	end
/*	
	always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr <= 8'd0;
    else
      	if (addr0_en == 1'b1)
      	  addr <= addr_0[10:3];
      	if (addr1_en == 1'b1)
      	  addr <= addr_1[10:3];
      	if (addr2_en == 1'b1)
      	  addr <= addr_2[10:3];
      	if (addr3_en == 1'b1)
      	  addr <= addr_3[10:3];
      	if (addr4_en == 1'b1)
      	  addr <= addr_4[10:3];
      	if (addr5_en == 1'b1)
      	  addr <= addr_5[10:3];
      	if (addr6_en == 1'b1)
      	  addr <= addr_6[10:3];
      	if (addr7_en == 1'b1)
      	  addr <= addr_7[10:3];
	end
	
*/

  always @ (posedge clk) begin
    if (rst_n == 1'b0)
      addr <= 8'd0;
    else
      case ({addr0_en,addr1_en,addr2_en,addr3_en,addr4_en,addr5_en,addr6_en,addr7_en})
        8'b1000_0000 : addr <= addr_0[10:3];
        8'b0100_0000 : addr <= addr_1[10:3];
        8'b0010_0000 : addr <= addr_2[10:3];
        8'b0001_0000 : addr <= addr_3[10:3];
        8'b0000_1000 : addr <= addr_4[10:3];
        8'b0000_0100 : addr <= addr_5[10:3];
        8'b0000_0010 : addr <= addr_6[10:3];
        8'b0000_0001 : addr <= addr_7[10:3];
        default      : addr <= 8'd0;
      endcase
  end			
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_0 <= 11'd0;
		else
			if (addr0_en == 1'b1)
				addr_0 <= addr_0 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_0 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_1 <= 11'd0;
		else
			if (addr1_en == 1'b1)
				addr_1 <= addr_1 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_1 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_2 <= 11'd0;
		else
			if (addr2_en == 1'b1)
				addr_2 <= addr_2 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_2 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_3 <= 11'd0;
		else
			if (addr3_en == 1'b1)
				addr_3 <= addr_3 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_3 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_4 <= 11'd0;
		else
			if (addr4_en == 1'b1)
				addr_4 <= addr_4 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_4 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_5 <= 11'd0;
		else
			if (addr5_en == 1'b1)
				addr_5 <= addr_5 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_5 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_6 <= 11'd0;
		else
			if (addr6_en == 1'b1)
				addr_6 <= addr_6 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_6 <= 11'd0;
	end
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0)
			addr_7 <= 11'd0;
		else
			if (addr7_en == 1'b1)
				addr_7 <= addr_7 + 1'b1;
			else	
				if (cnt_vs >= 500)
					addr_7 <= 11'd0;
	end
	
	reg			[2:0]			cnt;
	
	always @ (posedge clk) begin
		if (rst_n == 1'b0) begin
			vga_rgb <= 8'd0;
			cnt <= 3'd0;
			adrrp<=0;
		end
		else	
			if (data0_en | data1_en | data2_en | data3_en | data4_en | data5_en | data6_en | data7_en) begin
				cnt <= cnt + 1'b1;
				if (rom_data[7 - cnt] == 1'b1)
					vga_rgb <= 8'b111_000_00;
				else	
					vga_rgb <= 8'b000_111_00;
			end
			
			else if((cnt_vs >= VS_A + VS_B + 79) && (cnt_vs < VS_A + VS_B + 229) && (cnt_hs >= HS_A + HS_B + 245) && (cnt_hs < HS_A + HS_B + 150 + 245))begin
				if (adrrp<22500 - 1)
					begin
						adrrp <= adrrp + 1;
						vga_rgb <= q;
					end 
				else
					adrrp <= 15'd0;
			end
			else begin
				cnt <= 3'd0;
				vga_rgb <= 8'd0;
				adrrp<=adrrp;		
			end 
	end
	
endmodule 
