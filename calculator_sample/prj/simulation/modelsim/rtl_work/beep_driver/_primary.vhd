library verilog;
use verilog.vl_types.all;
entity beep_driver is
    generic(
        beep_cnt_num    : integer := 100
    );
    port(
        clk_1khz        : in     vl_logic;
        flag            : in     vl_logic;
        beep            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of beep_cnt_num : constant is 1;
end beep_driver;
