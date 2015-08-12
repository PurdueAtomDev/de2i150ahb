library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_mram_top is
    generic(
        ADDR_WIDTH      : integer := 14;
        DATA_WIDTH      : integer := 72
    );
    port(
        core_clk        : in     vl_logic;
        dprio_mram_in   : in     vl_logic_vector(34 downto 0);
        addrA           : in     vl_logic_vector;
        addrB           : in     vl_logic_vector;
        data            : in     vl_logic_vector;
        wren            : in     vl_logic;
        dout            : out    vl_logic_vector;
        rstn            : in     vl_logic;
        srst            : in     vl_logic;
        bisten          : in     vl_logic;
        dprio_bist_in   : in     vl_logic_vector(74 downto 0);
        enscan          : in     vl_logic;
        rscen           : in     vl_logic;
        prv_mram        : in     vl_logic;
        rscin           : in     vl_logic;
        rscsel          : in     vl_logic;
        rscrst          : in     vl_logic;
        rsclk           : in     vl_logic;
        id              : in     vl_logic_vector(7 downto 0);
        scanen          : in     vl_logic;
        scanin          : in     vl_logic;
        mram_hip_test_enable: in     vl_logic;
        bist_scanen     : in     vl_logic;
        bist_scanin     : in     vl_logic;
        testen          : in     vl_logic;
        uncor_err_ext_en: in     vl_logic;
        scanout         : out    vl_logic;
        rscout          : out    vl_logic;
        bist_scanout    : out    vl_logic;
        bistdoneA       : out    vl_logic;
        bistdoneB       : out    vl_logic;
        pass            : out    vl_logic;
        derr            : out    vl_logic;
        derr_cor_ext    : out    vl_logic;
        nfrzdrv         : in     vl_logic;
        frzreg          : in     vl_logic;
        frzlogic        : in     vl_logic;
        scan_mode       : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end cycloneiv_pciehip_mram_top;
