library verilog;
use verilog.vl_types.all;
entity ahb_master_slave_with_qsys_bfm_mm_interconnect_0_rsp_mux is
    port(
        sink0_valid     : in     vl_logic;
        sink0_data      : in     vl_logic_vector(107 downto 0);
        sink0_channel   : in     vl_logic_vector(0 downto 0);
        sink0_startofpacket: in     vl_logic;
        sink0_endofpacket: in     vl_logic;
        sink0_ready     : out    vl_logic;
        src_valid       : out    vl_logic;
        src_data        : out    vl_logic_vector(107 downto 0);
        src_channel     : out    vl_logic_vector(0 downto 0);
        src_startofpacket: out    vl_logic;
        src_endofpacket : out    vl_logic;
        src_ready       : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end ahb_master_slave_with_qsys_bfm_mm_interconnect_0_rsp_mux;
