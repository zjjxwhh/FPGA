library verilog;
use verilog.vl_types.all;
entity freq is
    generic(
        cnt_num         : integer := 24999
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        clk_1khz        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of cnt_num : constant is 1;
end freq;
