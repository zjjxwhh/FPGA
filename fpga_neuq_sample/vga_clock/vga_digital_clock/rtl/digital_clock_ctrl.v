module digital_clock_ctrl (

  input   wire            clk_25m,
  input   wire            rst_n_25m,
  
  input   wire            flag_add,
  input   wire            flag_adjust,
  
  output  reg   [23:0]    digital_num,
  
  output  wire            h_adjust_en,
  output  wire            l_adjust_en
);

  parameter   T_1s =      25_000_000;
  
  localparam  T_half_s   = 12_500_000;
  
  reg           [31:0]    cnt;
  reg           [31:0]    cnt_half;
  wire                    adjust_en;
  reg           [4:0]     hour;
  reg           [5:0]     min;
  reg           [5:0]     sec;
  reg                     h_adjust;
  reg                     l_adjust;
  reg                     half_wave;
  wire          [23:0]    bcd;
  
  assign adjust_en = h_adjust | l_adjust;
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      cnt <= 32'd0;
    else
      if (cnt < T_1s - 1'b1 && adjust_en == 1'b0)
        cnt <= cnt + 1'b1;
      else
        cnt <= 32'd0;
  end
  
  wire  flag_1s = (cnt >= T_1s - 1'b1);
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      sec <= 6'd0;
    else
      if (flag_1s == 1'b1)
        if (sec < 6'd59)
          sec <= sec + 1'b1;
        else
          sec <= 6'd0;
     else
      sec <= sec;
  end
  
  wire flag_1min = (flag_1s == 1'b1 && sec >= 6'd59);
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)   
      min <= 6'd0;
    else
      if (flag_1min == 1'b1 || (flag_add == 1'b1 && l_adjust == 1'b1))
        if (min < 6'd59)
          min <= min + 1'b1;
        else
          min <= 6'd0;
      else
        min <= min;
  end
  
  wire flag_1hour = ((min >= 6'd59 && flag_1min == 1'b1) || (min >= 6'd59 && flag_add == 1'b1 && l_adjust == 1'b1));
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      hour <= 5'd0;
    else
      if (flag_1hour == 1'b1 || (flag_add == 1'b1 && h_adjust == 1'b1))
        if (hour < 5'd23)
          hour <= hour + 1'b1;
        else
          hour <= 5'd0;
      else
        hour <= hour;    
  end
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      h_adjust <= 1'b0;
    else
      if (h_adjust == 1'b0 && l_adjust == 1'b0 && flag_adjust == 1'b1)
        h_adjust <= 1'b1;
      else
        if (h_adjust == 1'b1 && flag_adjust == 1'b1)
          h_adjust <= 1'b0;
        else
          h_adjust <= h_adjust;
  end
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      l_adjust <= 1'b0;
    else
      if (h_adjust == 1'b1 && l_adjust == 1'b0 && flag_adjust == 1'b1)
        l_adjust <= 1'b1;
      else
        if (l_adjust == 1'b1 && flag_adjust == 1'b1)
          l_adjust <= 1'b0;
        else
          l_adjust <= l_adjust;
  end

  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      cnt_half <= 32'd0;
    else
      if (cnt_half < T_half_s - 1'b1)
        cnt_half <= cnt_half + 1'b1;
      else
        cnt_half <= 32'd0;
  end
  
  wire flag_half_s = (cnt_half >= T_half_s - 1'b1);
  
  always @ (posedge clk_25m) begin
    if (rst_n_25m == 1'b0)
      half_wave <= 1'b0;
    else
      if (flag_half_s == 1'b1)
        half_wave <= ~half_wave;
      else
        half_wave <= half_wave;
  end
  
  assign h_adjust_en = (h_adjust == 1'b1) ? half_wave : 1'b0;
  
  assign l_adjust_en = (l_adjust == 1'b1) ? half_wave : 1'b0;
  
  bintobcd bintobcd_sec(.bin(sec), .bcd(bcd[7:0]));
  bintobcd bintobcd_min(.bin(min), .bcd(bcd[15:8]));
  bintobcd bintobcd_hour(.bin(hour), .bcd(bcd[23:16]));

  always @ (posedge clk_25m) digital_num <= bcd;
  
endmodule 