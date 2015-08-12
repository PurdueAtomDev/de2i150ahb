library verilog;
use verilog.vl_types.all;
entity cycloneiv_controller is
    generic(
        lpm_type        : string  := "cycloneiv_controller"
    );
    port(
        usermode        : out    vl_logic;
        nceout          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of lpm_type : constant is 1;
end cycloneiv_controller;
