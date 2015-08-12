library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_cmu_clk_ctl is
    port(
        pclk_pma        : in     vl_logic;
        refclk_dig      : in     vl_logic;
        mdc             : in     vl_logic;
        ser_clk         : in     vl_logic;
        ser_mode        : in     vl_logic;
        scan_mode       : in     vl_logic;
        scan_clk        : in     vl_logic;
        rfreerun_centrl : in     vl_logic;
        rcentrl_clk_sel : in     vl_logic;
        rrefclk_out_div2: in     vl_logic;
        hard_reset      : in     vl_logic;
        txrst           : in     vl_logic;
        refclk_pma_out  : out    vl_logic;
        mdc_b           : out    vl_logic;
        refclk_out      : out    vl_logic;
        rauto_speed_ena : in     vl_logic;
        rfreq_sel       : in     vl_logic;
        gen2ngen1_bundle: in     vl_logic
    );
end cycloneiv_hssi_cmu_clk_ctl;
