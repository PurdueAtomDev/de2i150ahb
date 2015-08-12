library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_digi_bist_gen is
    port(
        bist_ctl_sg     : out    vl_logic_vector(1 downto 0);
        bist_data_sg    : out    vl_logic_vector(15 downto 0);
        rbist_sel       : in     vl_logic_vector(1 downto 0);
        rbisten_tx      : in     vl_logic;
        rcxpat_chnl_sel : in     vl_logic_vector(1 downto 0);
        rdwidth_tx      : in     vl_logic;
        rpma_doublewidth_tx: in     vl_logic;
        rpmadwidth_tx   : in     vl_logic;
        soft_reset      : in     vl_logic;
        tx_clk          : in     vl_logic
    );
end cycloneiv_hssi_tx_digi_bist_gen;
