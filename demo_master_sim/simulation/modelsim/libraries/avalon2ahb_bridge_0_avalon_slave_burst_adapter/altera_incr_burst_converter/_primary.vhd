library verilog;
use verilog.vl_types.all;
entity altera_incr_burst_converter is
    generic(
        LEN_W           : integer := 16;
        MAX_OUT_LEN     : integer := 4;
        NUM_SYMBOLS     : integer := 4;
        ADDR_W          : integer := 12;
        BNDRY_W         : integer := 12;
        BURSTSIZE_W     : integer := 3;
        IN_NARROW_SIZE  : integer := 0;
        PURELY_INCR_AVL_SYS: integer := 0;
        LOG2_NUM_SYMBOLS: integer := 4;
        OUT_LEN_W       : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        is_write        : in     vl_logic;
        in_len          : in     vl_logic_vector;
        in_sop          : in     vl_logic;
        in_addr         : in     vl_logic_vector;
        in_addr_reg     : in     vl_logic_vector;
        in_burstwrap_reg: in     vl_logic_vector;
        in_size         : in     vl_logic_vector;
        in_size_reg     : in     vl_logic_vector;
        out_len         : out    vl_logic_vector;
        uncompr_out_len : out    vl_logic_vector;
        out_addr        : out    vl_logic_vector;
        new_burst_export: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LEN_W : constant is 1;
    attribute mti_svvh_generic_type of MAX_OUT_LEN : constant is 1;
    attribute mti_svvh_generic_type of NUM_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of ADDR_W : constant is 1;
    attribute mti_svvh_generic_type of BNDRY_W : constant is 1;
    attribute mti_svvh_generic_type of BURSTSIZE_W : constant is 1;
    attribute mti_svvh_generic_type of IN_NARROW_SIZE : constant is 1;
    attribute mti_svvh_generic_type of PURELY_INCR_AVL_SYS : constant is 1;
    attribute mti_svvh_generic_type of LOG2_NUM_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of OUT_LEN_W : constant is 3;
end altera_incr_burst_converter;
