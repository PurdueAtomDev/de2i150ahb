library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_clkmux is
    port(
        resetn          : in     vl_logic;
        scan_mode       : in     vl_logic;
        pclk_ch0        : in     vl_logic;
        pclk_central    : in     vl_logic;
        pll_fixed_clk   : in     vl_logic;
        core_clk_in     : in     vl_logic;
        r_pclk_sel      : in     vl_logic;
        r_core_clk_source_sel: in     vl_logic_vector(1 downto 0);
        r_core_clk_div_sel: in     vl_logic_vector(2 downto 0);
        r_core_clk_out_sel: in     vl_logic;
        r_core_clk_dbg_sel: in     vl_logic;
        pclk_out        : out    vl_logic;
        core_clk        : out    vl_logic;
        core_clk_out    : out    vl_logic
    );
end cycloneiv_pciehip_clkmux;
