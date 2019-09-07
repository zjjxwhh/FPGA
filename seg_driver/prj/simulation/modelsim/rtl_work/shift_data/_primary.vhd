library verilog;
use verilog.vl_types.all;
entity shift_data is
    generic(
        cnt_num         : integer := 49999999
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_out        : out    vl_logic_vector(23 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of cnt_num : constant is 1;
end shift_data;
