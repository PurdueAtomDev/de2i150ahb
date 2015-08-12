library verilog;
use verilog.vl_types.all;
entity cycloneiv_oscillator is
    generic(
        lpm_type        : string  := "cycloneiv_oscillator";
        OSC_PW          : integer := 6250
    );
    port(
        oscena          : in     vl_logic;
        observableoutputport: out    vl_logic;
        clkout          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of lpm_type : constant is 1;
    attribute mti_svvh_generic_type of OSC_PW : constant is 1;
end cycloneiv_oscillator;
