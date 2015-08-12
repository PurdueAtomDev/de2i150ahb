library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_bist_ver is
    port(
        bistdone        : out    vl_logic;
        bisterr         : out    vl_logic;
        clk_2           : in     vl_logic;
        cur_state       : out    vl_logic_vector(4 downto 0);
        err_ctl         : out    vl_logic_vector(1 downto 0);
        err_data        : out    vl_logic_vector(15 downto 0);
        prbs_done       : in     vl_logic;
        prbs_err        : in     vl_logic;
        rbist_clr_rx    : in     vl_logic;
        rbist_sel       : in     vl_logic_vector(1 downto 0);
        rbisten_rx      : in     vl_logic;
        rcxpat_chnl_sel : in     vl_logic_vector(1 downto 0);
        rdwidth_rx      : in     vl_logic;
        rpma_doublewidth_rx: in     vl_logic;
        rpmadwidth_rx   : in     vl_logic;
        rxc             : in     vl_logic_vector(3 downto 0);
        rxd             : in     vl_logic_vector(63 downto 0);
        selftest_done   : out    vl_logic;
        selftest_err    : out    vl_logic;
        soft_reset      : in     vl_logic;
        sync_status     : in     vl_logic
    );
end cycloneiv_hssi_rx_digi_bist_ver;
