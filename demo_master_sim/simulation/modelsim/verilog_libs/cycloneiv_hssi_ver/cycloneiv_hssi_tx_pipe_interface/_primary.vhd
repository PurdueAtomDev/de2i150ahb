library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_pipe_interface is
    port(
        clk             : in     vl_logic;
        powerdown       : in     vl_logic_vector(1 downto 0);
        powerstate      : out    vl_logic_vector(3 downto 0);
        refclk_b        : in     vl_logic;
        refclk_b_reset_n: in     vl_logic;
        reset_n         : in     vl_logic;
        rev_loopbk      : out    vl_logic;
        revloopback     : in     vl_logic;
        rtx_elec_idle_delay: in     vl_logic_vector(2 downto 0);
        rtx_pipe_enable : in     vl_logic;
        rtxswing_sel_ena: in     vl_logic;
        tx_elec_idle    : out    vl_logic;
        tx_elec_idle_comp: in     vl_logic;
        txd             : out    vl_logic_vector(43 downto 0);
        txd_ch          : in     vl_logic_vector(43 downto 0);
        txdeemph        : in     vl_logic;
        txdeemph_int    : out    vl_logic;
        txdetectrx      : out    vl_logic;
        txdetectrxloopback: in     vl_logic;
        txelecidle      : in     vl_logic;
        txmargin        : in     vl_logic_vector(2 downto 0);
        txmargin_int    : out    vl_logic_vector(2 downto 0);
        txswing         : in     vl_logic;
        txswing_int     : out    vl_logic
    );
end cycloneiv_hssi_tx_pipe_interface;
