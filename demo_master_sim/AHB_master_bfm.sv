//
module AHB_master_bfm(
input logic clock,
input logic reset_n
);

   ahb_master_slave_with_qsys_bfm u0 (
	.clk_clk(clock),
	.reset_reset_n(reset_n)
	);



endmodule
