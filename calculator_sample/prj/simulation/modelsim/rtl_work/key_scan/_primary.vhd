library verilog;
use verilog.vl_types.all;
entity key_scan is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        row             : in     vl_logic_vector(3 downto 0);
        col             : out    vl_logic_vector(3 downto 0);
        flag            : out    vl_logic;
        press_num       : out    vl_logic_vector(3 downto 0)
    );
end key_scan;
