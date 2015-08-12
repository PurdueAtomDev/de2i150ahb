library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_pma_sub_tx_rx_det_rcv_det_fsm is
    generic(
        RESET           : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        WAKE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        STATE_1         : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        STATE_2         : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        HOLD            : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        com_pass        : in     vl_logic;
        probe_pass      : in     vl_logic;
        det_on          : out    vl_logic;
        detect_valid    : out    vl_logic;
        rcv_found       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RESET : constant is 1;
    attribute mti_svvh_generic_type of WAKE : constant is 1;
    attribute mti_svvh_generic_type of STATE_1 : constant is 1;
    attribute mti_svvh_generic_type of STATE_2 : constant is 1;
    attribute mti_svvh_generic_type of HOLD : constant is 1;
end cycloneiv_hssi_tx_pma_sub_tx_rx_det_rcv_det_fsm;
