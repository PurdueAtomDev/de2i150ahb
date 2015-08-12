library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_compute_bit is
    port(
        datain          : in     vl_logic_vector(63 downto 0);
        s               : in     vl_logic;
        r               : out    vl_logic
    );
end cycloneiv_pciehip_compute_bit;
