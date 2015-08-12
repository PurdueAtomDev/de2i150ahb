library verilog;
use verilog.vl_types.all;
entity alt3pram is
    generic(
        width           : integer := 1;
        widthad         : integer := 1;
        numwords        : integer := 0;
        lpm_file        : string  := "UNUSED";
        lpm_hint        : string  := "USE_EAB=ON";
        indata_reg      : string  := "UNREGISTERED";
        indata_aclr     : string  := "ON";
        write_reg       : string  := "UNREGISTERED";
        write_aclr      : string  := "ON";
        rdaddress_reg_a : string  := "UNREGISTERED";
        rdaddress_aclr_a: string  := "ON";
        rdcontrol_reg_a : string  := "UNREGISTERED";
        rdcontrol_aclr_a: string  := "ON";
        rdaddress_reg_b : string  := "UNREGISTERED";
        rdaddress_aclr_b: string  := "ON";
        rdcontrol_reg_b : string  := "UNREGISTERED";
        rdcontrol_aclr_b: string  := "ON";
        outdata_reg_a   : string  := "UNREGISTERED";
        outdata_aclr_a  : string  := "ON";
        outdata_reg_b   : string  := "UNREGISTERED";
        outdata_aclr_b  : string  := "ON";
        intended_device_family: string  := "Stratix";
        ram_block_type  : string  := "AUTO";
        maximum_depth   : integer := 0;
        lpm_type        : string  := "alt3pram"
    );
    port(
        wren            : in     vl_logic;
        data            : in     vl_logic_vector;
        wraddress       : in     vl_logic_vector;
        inclock         : in     vl_logic;
        inclocken       : in     vl_logic;
        rden_a          : in     vl_logic;
        rden_b          : in     vl_logic;
        rdaddress_a     : in     vl_logic_vector;
        rdaddress_b     : in     vl_logic_vector;
        outclock        : in     vl_logic;
        outclocken      : in     vl_logic;
        aclr            : in     vl_logic;
        qa              : out    vl_logic_vector;
        qb              : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of widthad : constant is 1;
    attribute mti_svvh_generic_type of numwords : constant is 1;
    attribute mti_svvh_generic_type of lpm_file : constant is 1;
    attribute mti_svvh_generic_type of lpm_hint : constant is 1;
    attribute mti_svvh_generic_type of indata_reg : constant is 1;
    attribute mti_svvh_generic_type of indata_aclr : constant is 1;
    attribute mti_svvh_generic_type of write_reg : constant is 1;
    attribute mti_svvh_generic_type of write_aclr : constant is 1;
    attribute mti_svvh_generic_type of rdaddress_reg_a : constant is 1;
    attribute mti_svvh_generic_type of rdaddress_aclr_a : constant is 1;
    attribute mti_svvh_generic_type of rdcontrol_reg_a : constant is 1;
    attribute mti_svvh_generic_type of rdcontrol_aclr_a : constant is 1;
    attribute mti_svvh_generic_type of rdaddress_reg_b : constant is 1;
    attribute mti_svvh_generic_type of rdaddress_aclr_b : constant is 1;
    attribute mti_svvh_generic_type of rdcontrol_reg_b : constant is 1;
    attribute mti_svvh_generic_type of rdcontrol_aclr_b : constant is 1;
    attribute mti_svvh_generic_type of outdata_reg_a : constant is 1;
    attribute mti_svvh_generic_type of outdata_aclr_a : constant is 1;
    attribute mti_svvh_generic_type of outdata_reg_b : constant is 1;
    attribute mti_svvh_generic_type of outdata_aclr_b : constant is 1;
    attribute mti_svvh_generic_type of intended_device_family : constant is 1;
    attribute mti_svvh_generic_type of ram_block_type : constant is 1;
    attribute mti_svvh_generic_type of maximum_depth : constant is 1;
    attribute mti_svvh_generic_type of lpm_type : constant is 1;
end alt3pram;