library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_pma_sub_tx_rx_det_div_by_2 is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        clkout          : out    vl_logic
    );
end cycloneiv_hssi_tx_pma_sub_tx_rx_det_div_by_2;
