library verilog;
use verilog.vl_types.all;
entity fifo_r is
    generic(
        DATAWIDTH       : integer := 32;
        FIFO_DEPTH      : integer := 32;
        FIFO_DEPTH_LOG2 : integer := 5
    );
    port(
        aclr            : in     vl_logic;
        data            : in     vl_logic_vector;
        rdclk           : in     vl_logic;
        rdreq           : in     vl_logic;
        wrclk           : in     vl_logic;
        wrreq           : in     vl_logic;
        q               : out    vl_logic_vector;
        rdempty         : out    vl_logic;
        wrusedw         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATAWIDTH : constant is 1;
    attribute mti_svvh_generic_type of FIFO_DEPTH : constant is 1;
    attribute mti_svvh_generic_type of FIFO_DEPTH_LOG2 : constant is 1;
end fifo_r;
