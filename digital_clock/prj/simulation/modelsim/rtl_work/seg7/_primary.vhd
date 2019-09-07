library verilog;
use verilog.vl_types.all;
entity seg7 is
    port(
        clk_1khz        : in     vl_logic;
        rst_n           : in     vl_logic;
        data_in         : in     vl_logic_vector(23 downto 0);
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0)
    );
end seg7;
