library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_pciexp_dcfiforam is
    generic(
        addr_width      : integer := 4;
        data_width      : integer := 32
    );
    port(
        data            : in     vl_logic_vector;
        wren            : in     vl_logic;
        wraddress       : in     vl_logic_vector;
        rdaddress       : in     vl_logic_vector;
        wrclock         : in     vl_logic;
        rdclock         : in     vl_logic;
        q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of addr_width : constant is 1;
    attribute mti_svvh_generic_type of data_width : constant is 1;
end cycloneiv_pciehip_pciexp_dcfiforam;
