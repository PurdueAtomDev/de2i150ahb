library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_pcs_reset is
    port(
        hard_reset      : in     vl_logic;
        clk_2_b         : in     vl_logic;
        refclk_b_in     : in     vl_logic;
        scan_mode       : in     vl_logic;
        rxpcs_rst       : in     vl_logic;
        txpcs_rst       : in     vl_logic;
        rxrst_int       : out    vl_logic;
        txrst_int       : out    vl_logic
    );
end cycloneiv_hssi_pcs_reset;
