library verilog;
use verilog.vl_types.all;
entity compute is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_in         : in     vl_logic_vector(3 downto 0);
        flag            : in     vl_logic;
        data_out        : out    vl_logic_vector(23 downto 0)
    );
end compute;
