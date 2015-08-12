library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_cmu_auto_speed_neg is
    generic(
        WAIT_RATE_CHANGE: vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        WAIT_FOR_PHFIFO : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        DISABLE_PC_BYTE : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        SET_CONFIG_SEL  : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        WAIT_GEN2NGEN1_CHANGE: vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        WAIT_PMA_DONE_CNTR: vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        DEASSERT_PC_PTR_RESET: vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        WAIT_DEASSERT_RST_CNTR: vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        ENABLE_PC_BYTE  : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        WAIT_ENABLE_CNTR: vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1);
        SPEED_CHANGE_DONE: vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi0)
    );
    port(
        refclk          : in     vl_logic;
        rxpcs_rst_int   : in     vl_logic;
        rate            : in     vl_logic;
        gen2ngen1       : in     vl_logic;
        config_sel_centrl: in     vl_logic;
        config_sel_quad_up: in     vl_logic;
        config_sel_quad_down: in     vl_logic;
        rindv_rx        : in     vl_logic;
        rmaster_rx      : in     vl_logic;
        rmaster_up_rx   : in     vl_logic;
        rauto_speed_ena : in     vl_logic;
        singleorbundle  : in     vl_logic;
        rphfifo_regmode_rx: in     vl_logic;
        rpma_done_count : in     vl_logic_vector(17 downto 0);
        rauto_deassert_pc_rst_cnt: in     vl_logic_vector(3 downto 0);
        rauto_pc_en_cnt : in     vl_logic_vector(4 downto 0);
        rwait_for_phfifo_cnt: in     vl_logic_vector(5 downto 0);
        config_sel      : out    vl_logic;
        pcie_switch     : out    vl_logic;
        speed_change    : out    vl_logic;
        dis_pc_byte     : out    vl_logic;
        reset_pc_ptrs   : out    vl_logic;
        cs              : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WAIT_RATE_CHANGE : constant is 1;
    attribute mti_svvh_generic_type of WAIT_FOR_PHFIFO : constant is 1;
    attribute mti_svvh_generic_type of DISABLE_PC_BYTE : constant is 1;
    attribute mti_svvh_generic_type of SET_CONFIG_SEL : constant is 1;
    attribute mti_svvh_generic_type of WAIT_GEN2NGEN1_CHANGE : constant is 1;
    attribute mti_svvh_generic_type of WAIT_PMA_DONE_CNTR : constant is 1;
    attribute mti_svvh_generic_type of DEASSERT_PC_PTR_RESET : constant is 1;
    attribute mti_svvh_generic_type of WAIT_DEASSERT_RST_CNTR : constant is 1;
    attribute mti_svvh_generic_type of ENABLE_PC_BYTE : constant is 1;
    attribute mti_svvh_generic_type of WAIT_ENABLE_CNTR : constant is 1;
    attribute mti_svvh_generic_type of SPEED_CHANGE_DONE : constant is 1;
end cycloneiv_hssi_cmu_auto_speed_neg;
