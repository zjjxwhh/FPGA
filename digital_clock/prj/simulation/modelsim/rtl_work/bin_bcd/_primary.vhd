library verilog;
use verilog.vl_types.all;
entity bin_bcd is
    port(
        bin             : inout  vl_logic_vector(7 downto 0);
        bcd             : out    vl_logic_vector(7 downto 0)
    );
end bin_bcd;
