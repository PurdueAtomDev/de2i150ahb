library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_cmu_rx_ctrl is
    port(
        soft_reset      : in     vl_logic;
        clk_2           : in     vl_logic;
        rx_rd_clk       : in     vl_logic;
        rx_wr_clk       : in     vl_logic;
        scan_mode       : in     vl_logic;
        rrxfifo_urst_en : in     vl_logic;
        rxfifo_urst     : in     vl_logic;
        rrxphfifopldctl_en: in     vl_logic;
        pld_wr_dis      : in     vl_logic;
        pld_re          : in     vl_logic;
        dis_pc_byte     : in     vl_logic;
        rauto_speed_ena : in     vl_logic;
        rx_we_out       : out    vl_logic;
        wr_enable_out   : out    vl_logic;
        rd_enable_out   : out    vl_logic
    );
end cycloneiv_hssi_cmu_rx_ctrl;
