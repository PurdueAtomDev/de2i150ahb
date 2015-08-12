library verilog;
use verilog.vl_types.all;
entity altera_default_burst_converter is
    generic(
        BURST_TYPE_W    : integer := 2;
        BNDRY_W         : integer := 5;
        ADDR_W          : integer := 12;
        BYTEEN_W        : integer := 8;
        BURST_SIZE_W    : integer := 3;
        IN_NARROW_SIZE  : integer := 0;
        IS_AXI_SLAVE    : integer := 0;
        LEN_W           : integer := 2;
        LOG2_NUM_SYMBOLS: integer := 4
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        in_bursttype    : in     vl_logic_vector;
        in_burstwrap_reg: in     vl_logic_vector;
        in_addr         : in     vl_logic_vector;
        in_addr_reg     : in     vl_logic_vector;
        in_len          : in     vl_logic_vector;
        in_size_value   : in     vl_logic_vector;
        in_is_write     : in     vl_logic;
        out_addr        : out    vl_logic_vector;
        out_len         : out    vl_logic_vector;
        new_burst       : out    vl_logic;
        out_byteen      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BURST_TYPE_W : constant is 1;
    attribute mti_svvh_generic_type of BNDRY_W : constant is 1;
    attribute mti_svvh_generic_type of ADDR_W : constant is 1;
    attribute mti_svvh_generic_type of BYTEEN_W : constant is 1;
    attribute mti_svvh_generic_type of BURST_SIZE_W : constant is 1;
    attribute mti_svvh_generic_type of IN_NARROW_SIZE : constant is 1;
    attribute mti_svvh_generic_type of IS_AXI_SLAVE : constant is 1;
    attribute mti_svvh_generic_type of LEN_W : constant is 1;
    attribute mti_svvh_generic_type of LOG2_NUM_SYMBOLS : constant is 1;
end altera_default_burst_converter;
