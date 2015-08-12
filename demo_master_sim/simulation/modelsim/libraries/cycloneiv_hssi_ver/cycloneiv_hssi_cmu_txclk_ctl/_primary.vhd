library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_cmu_txclk_ctl is
    port(
        pld_tx_clk      : in     vl_logic;
        refclk_pma      : in     vl_logic;
        txpma_local_clk : in     vl_logic;
        txrst           : in     vl_logic;
        scan_mode       : in     vl_logic;
        gen2ngen1       : in     vl_logic;
        gen2ngen1_bundle: in     vl_logic;
        tx_div2_sync_centrl: in     vl_logic;
        tx_div2_sync_quad_up: in     vl_logic;
        tx_div2_sync_quad_down: in     vl_logic;
        rindv_tx        : in     vl_logic;
        rtxwrclksel     : in     vl_logic;
        rtxrdclksel     : in     vl_logic;
        rdwidth_tx      : in     vl_logic;
        rfreerun_tx     : in     vl_logic;
        rauto_speed_ena : in     vl_logic;
        rfreq_sel       : in     vl_logic;
        rtxpcsclkpwdn   : in     vl_logic;
        rmaster_tx      : in     vl_logic;
        rmaster_up_tx   : in     vl_logic;
        rself_sw_en_tx  : in     vl_logic;
        refclk_b        : out    vl_logic;
        wr_clk_pos      : out    vl_logic;
        fifo_rd_clk     : out    vl_logic;
        tx_clk_out      : out    vl_logic;
        refclk_b_raw    : out    vl_logic;
        wr_clk_pos_raw  : out    vl_logic;
        fifo_rd_clk_raw : out    vl_logic;
        tx_div2_sync_out: out    vl_logic
    );
end cycloneiv_hssi_cmu_txclk_ctl;
