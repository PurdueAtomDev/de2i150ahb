library verilog;
use verilog.vl_types.all;
entity ahb_master_slave_with_qsys_bfm is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        ahb_master_slave_2_0_conduit_end_add_data_sel: in     vl_logic;
        ahb_master_slave_2_0_conduit_end_display_data: out    vl_logic_vector(31 downto 0);
        ahb_master_slave_2_0_conduit_end_rdwr_address: in     vl_logic_vector(15 downto 0)
    );
end ahb_master_slave_with_qsys_bfm;
