
module ahb_master_slave_with_qsys_bfm (
	clk_clk,
	reset_reset_n,
	ahb_master_slave_2_0_conduit_end_add_data_sel,
	ahb_master_slave_2_0_conduit_end_display_data,
	ahb_master_slave_2_0_conduit_end_rdwr_address);	

	input		clk_clk;
	input		reset_reset_n;
	input		ahb_master_slave_2_0_conduit_end_add_data_sel;
	output	[31:0]	ahb_master_slave_2_0_conduit_end_display_data;
	input	[15:0]	ahb_master_slave_2_0_conduit_end_rdwr_address;
endmodule
