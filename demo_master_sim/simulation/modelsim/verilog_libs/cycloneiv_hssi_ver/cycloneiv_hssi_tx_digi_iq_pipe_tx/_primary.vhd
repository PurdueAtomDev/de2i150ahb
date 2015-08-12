library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_digi_iq_pipe_tx is
    port(
        fifo_rd_clk_raw : in     vl_logic;
        fifo_select_in_centrl: in     vl_logic;
        fifo_select_in_pipe_quad_down: in     vl_logic;
        fifo_select_in_pipe_quad_up: in     vl_logic;
        fifo_select_out_pipe: out    vl_logic;
        rd_enable_in_centrl: in     vl_logic;
        rd_enable_in_pipe_quad_down: in     vl_logic;
        rd_enable_in_pipe_quad_up: in     vl_logic;
        rd_enable_out_pipe: out    vl_logic;
        refclk_b_raw    : in     vl_logic;
        rfreerun_tx     : in     vl_logic;
        rmaster_tx      : in     vl_logic;
        rmaster_up_tx   : in     vl_logic;
        rpipeline_bypass_tx: in     vl_logic;
        soft_reset_rclk1: in     vl_logic;
        soft_reset_wclk1: in     vl_logic;
        tx_div2_sync_in_centrl: in     vl_logic;
        tx_div2_sync_in_pipe_quad_down: in     vl_logic;
        tx_div2_sync_in_pipe_quad_up: in     vl_logic;
        tx_div2_sync_out_pipe: out    vl_logic;
        txrst           : in     vl_logic;
        wr_clk_pos_raw  : in     vl_logic;
        wr_enable_in_centrl: in     vl_logic;
        wr_enable_in_pipe_quad_down: in     vl_logic;
        wr_enable_in_pipe_quad_up: in     vl_logic;
        wr_enable_out_pipe: out    vl_logic
    );
end cycloneiv_hssi_tx_digi_iq_pipe_tx;
