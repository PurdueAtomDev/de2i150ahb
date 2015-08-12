library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_cmu_tx_ctrl is
    port(
        soft_reset      : in     vl_logic;
        fifo_wr_clk     : in     vl_logic;
        fifo_rd_clk     : in     vl_logic;
        refclk_b_in     : in     vl_logic;
        scan_mode       : in     vl_logic;
        rtxfifo_urst_en : in     vl_logic;
        txfifo_urst     : in     vl_logic;
        rtxphfifopldctl_en: in     vl_logic;
        pld_we          : in     vl_logic;
        pld_rd_dis      : in     vl_logic;
        dis_pc_byte     : in     vl_logic;
        rauto_speed_ena : in     vl_logic;
        wr_enable_out   : out    vl_logic;
        rd_enable_out   : out    vl_logic;
        fifo_select_out : out    vl_logic
    );
end cycloneiv_hssi_cmu_tx_ctrl;
