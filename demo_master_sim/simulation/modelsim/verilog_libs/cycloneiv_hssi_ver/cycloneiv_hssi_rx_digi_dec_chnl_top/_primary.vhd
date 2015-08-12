library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_dec_chnl_top is
    port(
        cascaded_8b10b_en: in     vl_logic;
        clk_2           : in     vl_logic;
        data_in         : in     vl_logic_vector(31 downto 0);
        data_in_valid   : in     vl_logic_vector(1 downto 0);
        dec_ctl         : out    vl_logic_vector(1 downto 0);
        dec_data        : out    vl_logic_vector(15 downto 0);
        dec_data_valid  : out    vl_logic_vector(1 downto 0);
        disp_err_delay  : out    vl_logic_vector(1 downto 0);
        disp_val_delay  : out    vl_logic_vector(1 downto 0);
        invalid_code_delay: out    vl_logic_vector(1 downto 0);
        ovr_undflow     : out    vl_logic_vector(3 downto 0);
        polinv          : in     vl_logic;
        r8b10b_dec_ibm_en: in     vl_logic_vector(1 downto 0);
        renpolinv       : in     vl_logic;
        rerr_flags_sel  : in     vl_logic;
        rlb_data        : out    vl_logic_vector(19 downto 0);
        rrxpcsbypass_en : in     vl_logic;
        rst             : in     vl_logic;
        sync_resync_delay: out    vl_logic_vector(1 downto 0);
        tenb_data       : out    vl_logic_vector(19 downto 0)
    );
end cycloneiv_hssi_rx_digi_dec_chnl_top;
