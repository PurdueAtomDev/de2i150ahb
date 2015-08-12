library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_hip_mram is
    generic(
        ADDR_WIDTH      : integer := 14;
        DATA_WIDTH      : integer := 72
    );
    port(
        dprio_mram_in   : in     vl_logic_vector(16 downto 0);
        wrclock         : in     vl_logic;
        wren            : in     vl_logic;
        rden            : in     vl_logic;
        wraddress       : in     vl_logic_vector;
        data            : in     vl_logic_vector;
        rdclock         : in     vl_logic;
        rdaddress       : in     vl_logic_vector;
        addrstallA      : in     vl_logic;
        addrstallB      : in     vl_logic;
        r0_regscanin    : in     vl_logic;
        r1_regscanin    : in     vl_logic;
        r2_regscanin    : in     vl_logic;
        r3_regscanin    : in     vl_logic;
        r4_regscanin    : in     vl_logic;
        r5_regscanin    : in     vl_logic;
        r6_regscanin    : in     vl_logic;
        r7_regscanin    : in     vl_logic;
        rsclk           : in     vl_logic;
        rscen           : in     vl_logic;
        rscin           : in     vl_logic;
        rscsel          : in     vl_logic;
        rscrst          : in     vl_logic;
        id              : in     vl_logic_vector(7 downto 0);
        q               : out    vl_logic_vector;
        DFT_out         : out    vl_logic_vector(7 downto 0);
        rscout          : out    vl_logic;
        r0_regscanout   : out    vl_logic;
        r1_regscanout   : out    vl_logic;
        r2_regscanout   : out    vl_logic;
        r3_regscanout   : out    vl_logic;
        r4_regscanout   : out    vl_logic;
        r5_regscanout   : out    vl_logic;
        r6_regscanout   : out    vl_logic;
        r7_regscanout   : out    vl_logic;
        nfrzdrv         : in     vl_logic;
        frzreg          : in     vl_logic;
        frzlogic        : in     vl_logic;
        wrap_back_data  : in     vl_logic_vector(71 downto 0);
        flag            : out    vl_logic_vector(2 downto 0);
        prv_mram        : in     vl_logic;
        mram_hip_test_enable: in     vl_logic;
        scanen          : in     vl_logic;
        enscan          : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end cycloneiv_pciehip_hip_mram;
