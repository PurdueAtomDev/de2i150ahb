library verilog;
use verilog.vl_types.all;
entity altera_merlin_address_alignment is
    generic(
        ADDR_W          : integer := 12;
        BURSTWRAP_W     : integer := 12;
        TYPE_W          : integer := 2;
        SIZE_W          : integer := 3;
        INCREMENT_ADDRESS: integer := 1;
        NUMSYMBOLS      : integer := 8;
        SELECT_BITS     : vl_notype;
        IN_DATA_W       : vl_notype;
        OUT_DATA_W      : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        in_data         : in     vl_logic_vector;
        in_valid        : in     vl_logic;
        in_sop          : in     vl_logic;
        in_eop          : in     vl_logic;
        out_data        : out    vl_logic_vector;
        out_ready       : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_W : constant is 1;
    attribute mti_svvh_generic_type of BURSTWRAP_W : constant is 1;
    attribute mti_svvh_generic_type of TYPE_W : constant is 1;
    attribute mti_svvh_generic_type of SIZE_W : constant is 1;
    attribute mti_svvh_generic_type of INCREMENT_ADDRESS : constant is 1;
    attribute mti_svvh_generic_type of NUMSYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of SELECT_BITS : constant is 3;
    attribute mti_svvh_generic_type of IN_DATA_W : constant is 3;
    attribute mti_svvh_generic_type of OUT_DATA_W : constant is 3;
end altera_merlin_address_alignment;
