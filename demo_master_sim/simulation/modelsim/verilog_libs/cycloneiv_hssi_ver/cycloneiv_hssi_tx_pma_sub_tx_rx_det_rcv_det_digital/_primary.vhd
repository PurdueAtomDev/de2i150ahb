library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_pma_sub_tx_rx_det_rcv_det_digital is
    port(
        oscclk          : in     vl_logic;
        rcv_det_pdb     : in     vl_logic;
        rcv_det_en      : in     vl_logic;
        com_pass        : in     vl_logic;
        probe_pass      : in     vl_logic;
        det_on          : out    vl_logic;
        detect_valid    : out    vl_logic;
        rcv_found       : out    vl_logic
    );
end cycloneiv_hssi_tx_pma_sub_tx_rx_det_rcv_det_digital;
