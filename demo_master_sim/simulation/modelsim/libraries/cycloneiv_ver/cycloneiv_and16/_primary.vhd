library verilog;
use verilog.vl_types.all;
entity cycloneiv_and16 is
    port(
        Y               : out    vl_logic_vector(15 downto 0);
        IN1             : in     vl_logic_vector(15 downto 0)
    );
end cycloneiv_and16;
