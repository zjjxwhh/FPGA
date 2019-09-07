module vga_digital_clock (

	input		wire						clk_50,
	
	input   wire            key_adjust,
	input   wire            key_add,
	
	output  wire            vga_hs,
	output  wire            vga_vs,
	output  wire    [7:0]   vga_rgb
);

	reg					rst_n;
	initial rst_n = 1'b0;
	always @ (posedge clk_50) rst_n <= 1'b1;
	
	wire        clk_25m;
	wire        pll_locked;
	reg         rst_n_25m;
	wire        adjust_wave;
	wire        add_wave;
	reg         adjust_wave_r;
	reg         add_wave_r;
	
	wire  [7:0] addr;
	wire  [7:0] q;
	wire  [14:0]adrrp;
	
	reg   [7:0] data_0;
	reg   [7:0] data_1;
	reg   [7:0] data_2;
	reg   [7:0] data_3;
	reg   [7:0] data_4;
	reg   [7:0] data_5;
	reg   [7:0] data_6;
	reg   [7:0] data_7;
	reg   [7:0] data_8;
	reg   [7:0] data_9;
	reg   [7:0] data_fuhao;
	
	reg   [7:0] data_0r;
	reg   [7:0] data_1r;
	reg   [7:0] data_2r;
	reg   [7:0] data_3r;
	reg   [7:0] data_4r;
	reg   [7:0] data_5r;
	reg   [7:0] data_6r;
	reg   [7:0] data_7r;
	reg   [7:0] data_8r;
	reg   [7:0] data_9r;
	reg   [7:0] data_fuhaor;
	
	wire  [2:0] sel;
	reg   [7:0] data;
	reg   [7:0] data_r;
	
	reg   [7:0] data_hh;
	reg   [7:0] data_hl;
	reg   [7:0] data_mh;
	reg   [7:0] data_ml;
	reg   [7:0] data_lh;
	reg   [7:0] data_ll;
	
	wire  [3:0] sec_ge;
	wire  [3:0] sec_shi;
	wire  [3:0] min_ge;
	wire  [3:0] min_shi;
	wire  [3:0] hour_ge;
	wire  [3:0] hour_shi;
	wire        h_adjust_en;
	wire        l_adjust_en;
	
	reg   [7:0] mem_0 [255:0];
	reg   [7:0] mem_1 [255:0];
	reg   [7:0] mem_2 [255:0];
	reg   [7:0] mem_3 [255:0];
	reg   [7:0] mem_4 [255:0];
	reg   [7:0] mem_5 [255:0];
	reg   [7:0] mem_6 [255:0];
	reg   [7:0] mem_7 [255:0];
	reg   [7:0] mem_8 [255:0];
	reg   [7:0] mem_9 [255:0];
	reg   [7:0] mem_fuhao [255:0];
	
	initial $readmemh("../zimo_data/zimo_0.txt", mem_0);
	initial $readmemh("../zimo_data/zimo_1.txt", mem_1);
	initial $readmemh("../zimo_data/zimo_2.txt", mem_2);
	initial $readmemh("../zimo_data/zimo_3.txt", mem_3);
	initial $readmemh("../zimo_data/zimo_4.txt", mem_4);
	initial $readmemh("../zimo_data/zimo_5.txt", mem_5);
	initial $readmemh("../zimo_data/zimo_6.txt", mem_6);
	initial $readmemh("../zimo_data/zimo_7.txt", mem_7);
	initial $readmemh("../zimo_data/zimo_8.txt", mem_8);
	initial $readmemh("../zimo_data/zimo_9.txt", mem_9);
	initial $readmemh("../zimo_data/zimo_fuhao.txt", mem_fuhao);
	
	always @ (posedge clk_25m) data_0 <= mem_0[addr];
	always @ (posedge clk_25m) data_1 <= mem_1[addr];
	always @ (posedge clk_25m) data_2 <= mem_2[addr];
	always @ (posedge clk_25m) data_3 <= mem_3[addr];
	always @ (posedge clk_25m) data_4 <= mem_4[addr];
	always @ (posedge clk_25m) data_5 <= mem_5[addr];
	always @ (posedge clk_25m) data_6 <= mem_6[addr];
	always @ (posedge clk_25m) data_7 <= mem_7[addr];
	always @ (posedge clk_25m) data_8 <= mem_8[addr];
	always @ (posedge clk_25m) data_9 <= mem_9[addr];
	always @ (posedge clk_25m) data_fuhao <= mem_fuhao[addr];
	
	always @ (posedge clk_25m) data_0r <= data_0;
	always @ (posedge clk_25m) data_1r <= data_1;
	always @ (posedge clk_25m) data_2r <= data_2;
	always @ (posedge clk_25m) data_3r <= data_3;
	always @ (posedge clk_25m) data_4r <= data_4;
	always @ (posedge clk_25m) data_5r <= data_5;
	always @ (posedge clk_25m) data_6r <= data_6;
	always @ (posedge clk_25m) data_7r <= data_7;
	always @ (posedge clk_25m) data_8r <= data_8;
	always @ (posedge clk_25m) data_9r <= data_9;
	always @ (posedge clk_25m) data_fuhaor <= data_fuhao;
	
	
	
	
	always @ * begin
    case (hour_shi)	  
	    4'd0    : data_hh = data_0r;
	    4'd1    : data_hh = data_1r;
	    4'd2    : data_hh = data_2r;    
	    default : data_hh = 8'd0;
  	endcase
	end
	
	always @ * begin
	  case (hour_ge)  
  	    4'd0  : data_hl = data_0r;
  	    4'd1  : data_hl = data_1r;
  	    4'd2  : data_hl = data_2r;
  	    4'd3  : data_hl = data_3r;
  	    4'd4  : data_hl = data_4r;
  	    4'd5  : data_hl = data_5r;
  	    4'd6  : data_hl = data_6r;
  	    4'd7  : data_hl = data_7r;
  	    4'd8  : data_hl = data_8r;
  	    4'd9  : data_hl = data_9r;
  	    default:data_hl = 8'd0;
	  endcase
	end
	
	always @ * begin
	  case (min_shi)  
  	    4'd0  : data_mh = data_0r;
  	    4'd1  : data_mh = data_1r;
  	    4'd2  : data_mh = data_2r;
  	    4'd3  : data_mh = data_3r;
  	    4'd4  : data_mh = data_4r;
  	    4'd5  : data_mh = data_5r;
  	    default:data_mh = 8'd0;
	  endcase
	end
	
	always @ * begin
	  case (min_ge)  
  	    4'd0  : data_ml = data_0r;
  	    4'd1  : data_ml = data_1r;
  	    4'd2  : data_ml = data_2r;
  	    4'd3  : data_ml = data_3r;
  	    4'd4  : data_ml = data_4r;
  	    4'd5  : data_ml = data_5r;
  	    4'd6  : data_ml = data_6r;
  	    4'd7  : data_ml = data_7r;
  	    4'd8  : data_ml = data_8r;
  	    4'd9  : data_ml = data_9r;
  	    default:data_ml = 8'd0;
	  endcase
	end
	
	always @ * begin
	  case (sec_shi)  
  	    4'd0  : data_lh = data_0r;
  	    4'd1  : data_lh = data_1r;
  	    4'd2  : data_lh = data_2r;
  	    4'd3  : data_lh = data_3r;
  	    4'd4  : data_lh = data_4r;
  	    4'd5  : data_lh = data_5r;
  	    default:data_lh = 8'd0;
	  endcase
	end
	
	always @ * begin
	  case (sec_ge)  
  	    4'd0  : data_ll = data_0r;
  	    4'd1  : data_ll = data_1r;
  	    4'd2  : data_ll = data_2r;
  	    4'd3  : data_ll = data_3r;
  	    4'd4  : data_ll = data_4r;
  	    4'd5  : data_ll = data_5r;
  	    4'd6  : data_ll = data_6r;
  	    4'd7  : data_ll = data_7r;
  	    4'd8  : data_ll = data_8r;
  	    4'd9  : data_ll = data_9r;
  	    default:data_ll = 8'd0;
	  endcase
	end
	
	always @ * begin
    case (sel)	  
	    3'd0    :   data = data_hh & {8{~h_adjust_en}};
	    3'd1    :   data = data_hl & {8{~h_adjust_en}};
	    3'd2    :   data = data_fuhaor;
	    3'd3    :   data = data_mh & {8{~l_adjust_en}};
	    3'd4    :   data = data_ml & {8{~l_adjust_en}};
	    3'd5    :   data = data_fuhaor;
	    3'd6    :   data = data_lh;
	    3'd7    :   data = data_ll;
	    default :   data = 8'd0;
	  endcase
	end
	
	always @ (posedge clk_25m) data_r <= data;
	
	pll	pll_inst (
      	.areset         ( ~rst_n ),
      	.inclk0         ( clk_50 ),
      	.c0             ( clk_25m ),
      	.locked         ( pll_locked )
      );

  always @ (posedge clk_25m) rst_n_25m <= pll_locked;
  
  key_filter key_filter_adjust(

      	.clk            (clk_25m),
      	.rst_n          (rst_n_25m),
      	
      	.key            (key_adjust), // low valid
      	
      	.key_wave       (adjust_wave)
      );
	my_rom my_rom_dut(
		.address(adrrp),
		.clock(clk_25m),
		.q(q)
	);

  key_filter key_filter_add(

      	.clk            (clk_25m),
      	.rst_n          (rst_n_25m),
      	
      	.key            (key_add), // low valid
      	
      	.key_wave       (add_wave)
      );
   
	//检测下降沿
  always @ (posedge clk_25m) add_wave_r <= add_wave;
  always @ (posedge clk_25m) adjust_wave_r <= adjust_wave;
  
  wire  flag_adjust = adjust_wave_r & (~adjust_wave);
  wire  flag_add = add_wave_r & (~add_wave);
  
  digital_clock_ctrl digital_clock_ctrl_inst(

        .clk_25m        (clk_25m),
        .rst_n_25m      (rst_n_25m),
        
        .flag_add       (flag_add),
        .flag_adjust    (flag_adjust),
        
        .digital_num    ({hour_shi, hour_ge, min_shi, min_ge, sec_shi, sec_ge}),
        
        .h_adjust_en    (h_adjust_en),
        .l_adjust_en    (l_adjust_en)
      );

  vga_ctrl vga_ctrl_inst(

      	.clk            (clk_25m),
      	.rst_n          (rst_n_25m),
      	
      	.vga_hs         (vga_hs),
      	.vga_vs         (vga_vs),
      	.vga_rgb        (vga_rgb),
      	
			.q(q),
			.adrrp(adrrp),
      	.addr           (addr),
      	.sel            (sel),
      	.rom_data       (data_r)
      );

endmodule 