library verilog;
use verilog.vl_types.all;
entity ahb_master_slave_with_qsys_bfm_mm_interconnect_3 is
    port(
        clk_0_clk_clk   : in     vl_logic;
        ahb2avalon_burst_bridge_0_reset_reset_bridge_in_reset_reset: in     vl_logic;
        ahb2avalon_burst_bridge_0_avalon_master_address: in     vl_logic_vector(31 downto 0);
        ahb2avalon_burst_bridge_0_avalon_master_waitrequest: out    vl_logic;
        ahb2avalon_burst_bridge_0_avalon_master_burstcount: in     vl_logic_vector(3 downto 0);
        ahb2avalon_burst_bridge_0_avalon_master_byteenable: in     vl_logic_vector(3 downto 0);
        ahb2avalon_burst_bridge_0_avalon_master_read: in     vl_logic;
        ahb2avalon_burst_bridge_0_avalon_master_readdata: out    vl_logic_vector(31 downto 0);
        ahb2avalon_burst_bridge_0_avalon_master_readdatavalid: out    vl_logic;
        ahb2avalon_burst_bridge_0_avalon_master_write: in     vl_logic;
        ahb2avalon_burst_bridge_0_avalon_master_writedata: in     vl_logic_vector(31 downto 0);
        mm_slave_bfm_0_s0_address: out    vl_logic_vector(4 downto 0);
        mm_slave_bfm_0_s0_write: out    vl_logic;
        mm_slave_bfm_0_s0_read: out    vl_logic;
        mm_slave_bfm_0_s0_readdata: in     vl_logic_vector(31 downto 0);
        mm_slave_bfm_0_s0_writedata: out    vl_logic_vector(31 downto 0);
        mm_slave_bfm_0_s0_byteenable: out    vl_logic_vector(3 downto 0);
        mm_slave_bfm_0_s0_readdatavalid: in     vl_logic;
        mm_slave_bfm_0_s0_waitrequest: in     vl_logic
    );
end ahb_master_slave_with_qsys_bfm_mm_interconnect_3;
