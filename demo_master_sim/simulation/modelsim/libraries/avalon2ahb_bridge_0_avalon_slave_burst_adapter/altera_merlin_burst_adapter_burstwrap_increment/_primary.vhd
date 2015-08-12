library verilog;
use verilog.vl_types.all;
entity altera_merlin_burst_adapter_burstwrap_increment is
    generic(
        WIDTH           : integer := 8
    );
    port(
        mask            : in     vl_logic_vector;
        inc             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end altera_merlin_burst_adapter_burstwrap_increment;
