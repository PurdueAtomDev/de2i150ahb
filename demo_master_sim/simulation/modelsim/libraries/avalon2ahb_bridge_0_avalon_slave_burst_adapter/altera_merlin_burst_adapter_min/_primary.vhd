library verilog;
use verilog.vl_types.all;
entity altera_merlin_burst_adapter_min is
    generic(
        PKT_BYTE_CNT_W  : integer := 8;
        PKT_BURSTWRAP_W : integer := 8;
        PIPELINE_POSITION: integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        c               : in     vl_logic_vector;
        c_enable        : in     vl_logic;
        d               : in     vl_logic_vector;
        result          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PKT_BYTE_CNT_W : constant is 1;
    attribute mti_svvh_generic_type of PKT_BURSTWRAP_W : constant is 1;
    attribute mti_svvh_generic_type of PIPELINE_POSITION : constant is 1;
end altera_merlin_burst_adapter_min;
