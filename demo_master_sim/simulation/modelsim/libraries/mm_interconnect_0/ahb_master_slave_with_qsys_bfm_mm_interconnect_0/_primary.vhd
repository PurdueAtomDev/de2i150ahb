library verilog;
use verilog.vl_types.all;
entity ahb_master_slave_with_qsys_bfm_mm_interconnect_0 is
    port(
        clk_0_clk_clk   : in     vl_logic;
        mm_master_bfm_0_clk_reset_reset_bridge_in_reset_reset: in     vl_logic;
        mm_master_bfm_0_m0_address: in     vl_logic_vector(31 downto 0);
        mm_master_bfm_0_m0_waitrequest: out    vl_logic;
        mm_master_bfm_0_m0_burstcount: in     vl_logic_vector(2 downto 0);
        mm_master_bfm_0_m0_byteenable: in     vl_logic_vector(3 downto 0);
        mm_master_bfm_0_m0_read: in     vl_logic;
        mm_master_bfm_0_m0_readdata: out    vl_logic_vector(31 downto 0);
        mm_master_bfm_0_m0_readdatavalid: out    vl_logic;
        mm_master_bfm_0_m0_write: in     vl_logic;
        mm_master_bfm_0_m0_writedata: in     vl_logic_vector(31 downto 0);
        avalon2ahb_bridge_0_avalon_slave_address: out    vl_logic_vector(4 downto 0);
        avalon2ahb_bridge_0_avalon_slave_write: out    vl_logic;
        avalon2ahb_bridge_0_avalon_slave_read: out    vl_logic;
        avalon2ahb_bridge_0_avalon_slave_readdata: in     vl_logic_vector(31 downto 0);
        avalon2ahb_bridge_0_avalon_slave_writedata: out    vl_logic_vector(31 downto 0);
        avalon2ahb_bridge_0_avalon_slave_readdatavalid: in     vl_logic;
        avalon2ahb_bridge_0_avalon_slave_waitrequest: in     vl_logic
    );
end ahb_master_slave_with_qsys_bfm_mm_interconnect_0;
