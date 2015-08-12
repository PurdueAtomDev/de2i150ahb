library verilog;
use verilog.vl_types.all;
entity AHB_master_bfm is
    port(
        clock           : in     vl_logic;
        reset_n         : in     vl_logic
    );
end AHB_master_bfm;
