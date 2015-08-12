library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_dprio_bit is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        sig_in          : in     vl_logic;
        ext_in          : in     vl_logic;
        serial_mode     : in     vl_logic;
        si              : in     vl_logic;
        shift           : in     vl_logic;
        mdio_dis        : in     vl_logic;
        sig_out         : out    vl_logic;
        so              : out    vl_logic
    );
end cycloneiv_pciehip_dprio_bit;
