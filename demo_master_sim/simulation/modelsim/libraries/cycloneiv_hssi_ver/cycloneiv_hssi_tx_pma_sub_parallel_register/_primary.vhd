library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_pma_sub_parallel_register is
    generic(
        channel_width   : integer := 4
    );
    port(
        clk             : in     vl_logic;
        enable          : in     vl_logic;
        datain          : in     vl_logic_vector;
        devclrn         : in     vl_logic;
        devpor          : in     vl_logic;
        dataout         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of channel_width : constant is 1;
end cycloneiv_hssi_tx_pma_sub_parallel_register;
