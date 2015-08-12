library verilog;
use verilog.vl_types.all;
entity altera_merlin_burst_adapter_adder is
    generic(
        WIDTH           : integer := 8
    );
    port(
        cin             : in     vl_logic;
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        sum             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end altera_merlin_burst_adapter_adder;
