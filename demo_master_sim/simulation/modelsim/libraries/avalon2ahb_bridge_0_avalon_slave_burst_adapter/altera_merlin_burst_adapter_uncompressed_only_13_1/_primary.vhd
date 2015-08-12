library verilog;
use verilog.vl_types.all;
entity altera_merlin_burst_adapter_uncompressed_only_13_1 is
    generic(
        PKT_BYTE_CNT_H  : integer := 5;
        PKT_BYTE_CNT_L  : integer := 0;
        PKT_BYTEEN_H    : integer := 83;
        PKT_BYTEEN_L    : integer := 80;
        ST_DATA_W       : integer := 84;
        ST_CHANNEL_W    : integer := 8
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sink0_valid     : in     vl_logic;
        sink0_data      : in     vl_logic_vector;
        sink0_channel   : in     vl_logic_vector;
        sink0_startofpacket: in     vl_logic;
        sink0_endofpacket: in     vl_logic;
        sink0_ready     : out    vl_logic;
        source0_valid   : out    vl_logic;
        source0_data    : out    vl_logic_vector;
        source0_channel : out    vl_logic_vector;
        source0_startofpacket: out    vl_logic;
        source0_endofpacket: out    vl_logic;
        source0_ready   : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PKT_BYTE_CNT_H : constant is 1;
    attribute mti_svvh_generic_type of PKT_BYTE_CNT_L : constant is 1;
    attribute mti_svvh_generic_type of PKT_BYTEEN_H : constant is 1;
    attribute mti_svvh_generic_type of PKT_BYTEEN_L : constant is 1;
    attribute mti_svvh_generic_type of ST_DATA_W : constant is 1;
    attribute mti_svvh_generic_type of ST_CHANNEL_W : constant is 1;
end altera_merlin_burst_adapter_uncompressed_only_13_1;
