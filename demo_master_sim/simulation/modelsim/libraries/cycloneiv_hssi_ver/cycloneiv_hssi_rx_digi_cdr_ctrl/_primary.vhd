library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_cdr_ctrl is
    port(
        adata           : in     vl_logic_vector(9 downto 0);
        adata_valid     : in     vl_logic;
        early_eios      : out    vl_logic;
        eidle_exit      : out    vl_logic;
        eiosdetect_int  : out    vl_logic;
        gen2ngen1       : in     vl_logic;
        gen2ngen1_bundle: in     vl_logic;
        inferred_rxvalid: out    vl_logic;
        ltr             : out    vl_logic;
        pipe_loopbk     : in     vl_logic;
        pld_ltr         : in     vl_logic;
        rcdr_ctrl_en    : in     vl_logic;
        rcid_en         : in     vl_logic;
        rcvd_clk        : in     vl_logic;
        rindv_rx        : in     vl_logic;
        rmask_count     : in     vl_logic_vector(9 downto 0);
        rrxvalid_mask   : in     vl_logic;
        rwait_count     : in     vl_logic_vector(7 downto 0);
        rxpcs_reset_int : in     vl_logic;
        sigdet          : in     vl_logic
    );
end cycloneiv_hssi_rx_digi_cdr_ctrl;
