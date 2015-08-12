library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_digi_prbs_gen is
    port(
        cid_en          : in     vl_logic;
        prbs_out        : out    vl_logic_vector(19 downto 0);
        rcid_len        : in     vl_logic_vector(7 downto 0);
        rcid_pattern    : in     vl_logic;
        rpma_doublewidth_tx: in     vl_logic;
        rpmadwidth_tx   : in     vl_logic;
        rprbs_en_tx     : in     vl_logic;
        rprbs_sel       : in     vl_logic_vector(2 downto 0);
        soft_reset      : in     vl_logic;
        tx_clk          : in     vl_logic
    );
end cycloneiv_hssi_tx_digi_prbs_gen;
