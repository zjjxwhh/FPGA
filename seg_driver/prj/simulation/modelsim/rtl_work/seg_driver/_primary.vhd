library verilog;
use verilog.vl_types.all;
entity seg_driver is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0)
    );
end seg_driver;
