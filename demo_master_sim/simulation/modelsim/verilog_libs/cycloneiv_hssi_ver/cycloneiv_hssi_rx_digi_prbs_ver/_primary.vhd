library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_prbs_ver is
    port(
        cid_en          : in     vl_logic;
        data_in         : in     vl_logic_vector(19 downto 0);
        encdet_prbs     : out    vl_logic;
        prbs_done       : out    vl_logic;
        prbs_err        : out    vl_logic;
        prbs_err_lt     : out    vl_logic;
        rall_one_dect_only: in     vl_logic;
        rcid_len        : in     vl_logic_vector(7 downto 0);
        rcid_pattern    : in     vl_logic;
        rcvd_clk        : in     vl_logic;
        rpma_doublewidth_rx: in     vl_logic;
        rpmadwidth_rx   : in     vl_logic;
        rprbs_clr_rslt_rx: in     vl_logic;
        rprbs_en_rx     : in     vl_logic;
        rprbs_sel       : in     vl_logic_vector(2 downto 0);
        scan_mode       : in     vl_logic;
        soft_reset      : in     vl_logic;
        sync_status     : in     vl_logic;
        verify_on       : out    vl_logic
    );
end cycloneiv_hssi_rx_digi_prbs_ver;
