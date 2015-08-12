library verilog;
use verilog.vl_types.all;
entity altera_wrap_burst_converter is
    generic(
        LEN_W           : integer := 16;
        MAX_OUT_LEN     : integer := 4;
        ADDR_W          : integer := 12;
        BNDRY_W         : integer := 12;
        NUM_SYMBOLS     : integer := 4;
        LOG2_NUM_SYMBOLS: integer := 4;
        AXI_SLAVE       : integer := 0;
        OPTIMIZE_WRITE_BURST: integer := 0;
        OUT_LEN_W       : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable_write    : in     vl_logic;
        enable_read     : in     vl_logic;
        in_len          : in     vl_logic_vector;
        first_len       : in     vl_logic_vector;
        in_sop          : in     vl_logic;
        in_addr         : in     vl_logic_vector;
        in_addr_reg     : in     vl_logic_vector;
        in_boundary     : in     vl_logic_vector;
        in_burstwrap    : in     vl_logic_vector;
        in_burstwrap_reg: in     vl_logic_vector;
        out_len         : out    vl_logic_vector;
        uncompr_out_len : out    vl_logic_vector;
        out_addr        : out    vl_logic_vector;
        new_burst_export: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LEN_W : constant is 1;
    attribute mti_svvh_generic_type of MAX_OUT_LEN : constant is 1;
    attribute mti_svvh_generic_type of ADDR_W : constant is 1;
    attribute mti_svvh_generic_type of BNDRY_W : constant is 1;
    attribute mti_svvh_generic_type of NUM_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of LOG2_NUM_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of AXI_SLAVE : constant is 1;
    attribute mti_svvh_generic_type of OPTIMIZE_WRITE_BURST : constant is 1;
    attribute mti_svvh_generic_type of OUT_LEN_W : constant is 3;
end altera_wrap_burst_converter;
