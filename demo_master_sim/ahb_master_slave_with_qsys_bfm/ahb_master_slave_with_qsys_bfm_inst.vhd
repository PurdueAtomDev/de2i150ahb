	component ahb_master_slave_with_qsys_bfm is
		port (
			clk_clk                                       : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                 : in  std_logic                     := 'X';             -- reset_n
			ahb_master_slave_2_0_conduit_end_add_data_sel : in  std_logic                     := 'X';             -- add_data_sel
			ahb_master_slave_2_0_conduit_end_display_data : out std_logic_vector(31 downto 0);                    -- display_data
			ahb_master_slave_2_0_conduit_end_rdwr_address : in  std_logic_vector(15 downto 0) := (others => 'X')  -- rdwr_address
		);
	end component ahb_master_slave_with_qsys_bfm;

	u0 : component ahb_master_slave_with_qsys_bfm
		port map (
			clk_clk                                       => CONNECTED_TO_clk_clk,                                       --                              clk.clk
			reset_reset_n                                 => CONNECTED_TO_reset_reset_n,                                 --                            reset.reset_n
			ahb_master_slave_2_0_conduit_end_add_data_sel => CONNECTED_TO_ahb_master_slave_2_0_conduit_end_add_data_sel, -- ahb_master_slave_2_0_conduit_end.add_data_sel
			ahb_master_slave_2_0_conduit_end_display_data => CONNECTED_TO_ahb_master_slave_2_0_conduit_end_display_data, --                                 .display_data
			ahb_master_slave_2_0_conduit_end_rdwr_address => CONNECTED_TO_ahb_master_slave_2_0_conduit_end_rdwr_address  --                                 .rdwr_address
		);

