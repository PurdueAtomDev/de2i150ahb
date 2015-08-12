library verilog;
use verilog.vl_types.all;
entity altera_avalon_st_pipeline_stage is
    generic(
        SYMBOLS_PER_BEAT: integer := 1;
        BITS_PER_SYMBOL : integer := 8;
        USE_PACKETS     : integer := 0;
        USE_EMPTY       : integer := 0;
        PIPELINE_READY  : integer := 1;
        CHANNEL_WIDTH   : integer := 0;
        ERROR_WIDTH     : integer := 0;
        DATA_WIDTH      : vl_notype;
        PACKET_WIDTH    : integer := 0;
        EMPTY_WIDTH     : integer := 0
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        in_ready        : out    vl_logic;
        in_valid        : in     vl_logic;
        in_data         : in     vl_logic_vector;
        in_channel      : in     vl_logic_vector;
        in_error        : in     vl_logic_vector;
        in_startofpacket: in     vl_logic;
        in_endofpacket  : in     vl_logic;
        in_empty        : in     vl_logic_vector;
        out_ready       : in     vl_logic;
        out_valid       : out    vl_logic;
        out_data        : out    vl_logic_vector;
        out_channel     : out    vl_logic_vector;
        out_error       : out    vl_logic_vector;
        out_startofpacket: out    vl_logic;
        out_endofpacket : out    vl_logic;
        out_empty       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SYMBOLS_PER_BEAT : constant is 1;
    attribute mti_svvh_generic_type of BITS_PER_SYMBOL : constant is 1;
    attribute mti_svvh_generic_type of USE_PACKETS : constant is 1;
    attribute mti_svvh_generic_type of USE_EMPTY : constant is 1;
    attribute mti_svvh_generic_type of PIPELINE_READY : constant is 1;
    attribute mti_svvh_generic_type of CHANNEL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ERROR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 3;
    attribute mti_svvh_generic_type of PACKET_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of EMPTY_WIDTH : constant is 1;
end altera_avalon_st_pipeline_stage;
