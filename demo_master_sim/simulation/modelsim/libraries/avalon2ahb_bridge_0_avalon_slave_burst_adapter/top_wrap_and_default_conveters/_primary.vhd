library verilog;
use verilog.vl_types.all;
entity top_wrap_and_default_conveters is
    generic(
        LEN_W           : integer := 4;
        MAX_OUT_LEN     : integer := 4;
        ADDR_W          : integer := 12;
        BNDRY_W         : integer := 12;
        OPTIMIZE_WRITE_BURST: integer := 0;
        BURST_TYPE_W    : integer := 2;
        BURST_SIZE_W    : integer := 2;
        IN_NARROW_SIZE  : integer := 1;
        BYTEEN_W        : integer := 4;
        NUM_SYMBOLS     : integer := 4;
        LOG2_NUM_SYMBOLS: integer := 2;
        IS_AXI_SLAVE    : integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable_read     : in     vl_logic;
        enable_write    : in     vl_logic;
        in_len          : in     vl_logic_vector;
        first_len       : in     vl_logic_vector;
        in_sop          : in     vl_logic;
        in_burstwrap    : in     vl_logic_vector;
        in_burstwrap_reg: in     vl_logic_vector;
        in_aligned_addr : in     vl_logic_vector;
        in_aligned_addr_reg: in     vl_logic_vector;
        wrap_conveter_out_len: out    vl_logic_vector;
        wrap_conveter_uncompr_out_len: out    vl_logic_vector;
        wrap_conveter_out_addr: out    vl_logic_vector;
        wrap_conveter_new_burst: out    vl_logic;
        enable_fixed_converter: in     vl_logic;
        in_bursttype    : in     vl_logic_vector;
        in_size_value   : in     vl_logic_vector;
        is_write        : in     vl_logic;
        fixed_conveter_out_len: out    vl_logic_vector;
        fixed_conveter_out_addr: out    vl_logic_vector;
        fixed_conveter_new_burst: out    vl_logic;
        out_byteen_pre  : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LEN_W : constant is 1;
    attribute mti_svvh_generic_type of MAX_OUT_LEN : constant is 1;
    attribute mti_svvh_generic_type of ADDR_W : constant is 1;
    attribute mti_svvh_generic_type of BNDRY_W : constant is 1;
    attribute mti_svvh_generic_type of OPTIMIZE_WRITE_BURST : constant is 1;
    attribute mti_svvh_generic_type of BURST_TYPE_W : constant is 1;
    attribute mti_svvh_generic_type of BURST_SIZE_W : constant is 1;
    attribute mti_svvh_generic_type of IN_NARROW_SIZE : constant is 1;
    attribute mti_svvh_generic_type of BYTEEN_W : constant is 1;
    attribute mti_svvh_generic_type of NUM_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of LOG2_NUM_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of IS_AXI_SLAVE : constant is 1;
end top_wrap_and_default_conveters;
