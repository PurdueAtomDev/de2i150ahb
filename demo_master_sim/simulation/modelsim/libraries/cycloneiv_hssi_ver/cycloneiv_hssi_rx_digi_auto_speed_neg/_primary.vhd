library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_auto_speed_neg is
    port(
        config_sel      : out    vl_logic;
        config_sel_centrl: in     vl_logic;
        config_sel_quad_down: in     vl_logic;
        config_sel_quad_up: in     vl_logic;
        cs              : out    vl_logic_vector(3 downto 0);
        dis_pc_byte     : out    vl_logic;
        gen2ngen1       : in     vl_logic;
        pcie_switch     : out    vl_logic;
        rate            : in     vl_logic;
        rauto_deassert_pc_rst_cnt: in     vl_logic_vector(3 downto 0);
        rauto_pc_en_cnt : in     vl_logic_vector(4 downto 0);
        rauto_speed_ena : in     vl_logic;
        refclk          : in     vl_logic;
        reset_pc_ptrs   : out    vl_logic;
        rindv_rx        : in     vl_logic;
        rmaster_rx      : in     vl_logic;
        rmaster_up_rx   : in     vl_logic;
        rphfifo_regmode_rx: in     vl_logic;
        rpma_done_count : in     vl_logic_vector(17 downto 0);
        rwait_for_phfifo_cnt: in     vl_logic_vector(5 downto 0);
        rxpcs_rst_int   : in     vl_logic;
        singleorbundle  : in     vl_logic;
        speed_change    : out    vl_logic
    );
end cycloneiv_hssi_rx_digi_auto_speed_neg;
