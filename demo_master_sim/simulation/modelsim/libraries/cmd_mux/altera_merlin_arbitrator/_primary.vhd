library verilog;
use verilog.vl_types.all;
entity altera_merlin_arbitrator is
    generic(
        NUM_REQUESTERS  : integer := 8;
        SCHEME          : string  := "round-robin";
        PIPELINE        : integer := 0
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        request         : in     vl_logic_vector;
        grant           : out    vl_logic_vector;
        increment_top_priority: in     vl_logic;
        save_top_priority: in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_REQUESTERS : constant is 1;
    attribute mti_svvh_generic_type of SCHEME : constant is 1;
    attribute mti_svvh_generic_type of PIPELINE : constant is 1;
end altera_merlin_arbitrator;
