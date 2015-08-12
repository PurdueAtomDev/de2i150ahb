library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_dskw_fifo is
    port(
        align_det_sync  : out    vl_logic;
        audi            : out    vl_logic_vector(13 downto 0);
        audi_pre        : out    vl_logic_vector(13 downto 0);
        clk_1           : in     vl_logic;
        en_dskw_gp      : in     vl_logic;
        en_dskw_qd      : in     vl_logic;
        fifo_rst_rd_gp  : in     vl_logic;
        fifo_rst_rd_qd  : in     vl_logic;
        rcvd_clk        : in     vl_logic;
        rd_align        : out    vl_logic;
        rdskchrp        : in     vl_logic_vector(9 downto 0);
        rdskposdisp     : in     vl_logic;
        sel_gp_md       : in     vl_logic;
        soft_reset      : in     vl_logic;
        sudi            : in     vl_logic_vector(13 downto 0)
    );
end cycloneiv_hssi_rx_digi_dskw_fifo;
