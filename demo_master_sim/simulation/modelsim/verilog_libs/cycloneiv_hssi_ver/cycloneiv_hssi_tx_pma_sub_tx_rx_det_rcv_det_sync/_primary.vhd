library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_pma_sub_tx_rx_det_rcv_det_sync is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        rcv_det         : in     vl_logic;
        rcv_det_out     : out    vl_logic
    );
end cycloneiv_hssi_tx_pma_sub_tx_rx_det_rcv_det_sync;
