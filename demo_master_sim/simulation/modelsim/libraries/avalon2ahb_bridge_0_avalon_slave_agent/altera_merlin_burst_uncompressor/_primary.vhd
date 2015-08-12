library verilog;
use verilog.vl_types.all;
entity altera_merlin_burst_uncompressor is
    generic(
        ADDR_W          : integer := 16;
        BURSTWRAP_W     : integer := 3;
        BYTE_CNT_W      : integer := 4;
        PKT_SYMBOLS     : integer := 4;
        BURST_SIZE_W    : integer := 3
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sink_startofpacket: in     vl_logic;
        sink_endofpacket: in     vl_logic;
        sink_valid      : in     vl_logic;
        sink_ready      : out    vl_logic;
        sink_addr       : in     vl_logic_vector;
        sink_burstwrap  : in     vl_logic_vector;
        sink_byte_cnt   : in     vl_logic_vector;
        sink_is_compressed: in     vl_logic;
        sink_burstsize  : in     vl_logic_vector;
        source_startofpacket: out    vl_logic;
        source_endofpacket: out    vl_logic;
        source_valid    : out    vl_logic;
        source_ready    : in     vl_logic;
        source_addr     : out    vl_logic_vector;
        source_burstwrap: out    vl_logic_vector;
        source_byte_cnt : out    vl_logic_vector;
        source_is_compressed: out    vl_logic;
        source_burstsize: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_W : constant is 1;
    attribute mti_svvh_generic_type of BURSTWRAP_W : constant is 1;
    attribute mti_svvh_generic_type of BYTE_CNT_W : constant is 1;
    attribute mti_svvh_generic_type of PKT_SYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of BURST_SIZE_W : constant is 1;
end altera_merlin_burst_uncompressor;
