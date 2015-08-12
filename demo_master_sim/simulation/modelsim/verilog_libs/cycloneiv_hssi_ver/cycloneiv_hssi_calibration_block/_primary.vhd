library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_calibration_block is
    generic(
        lpm_type        : string  := "cycloneiv_hssi_calibration_block";
        cont_cal_mode   : string  := "false";
        enable_rx_cal_tw: string  := "false";
        enable_tx_cal_tw: string  := "false";
        rtest           : string  := "false";
        rx_cal_wt_value : integer := 0;
        send_rx_cal_status: string  := "false";
        tx_cal_wt_value : integer := 1
    );
    port(
        clk             : in     vl_logic;
        powerdn         : in     vl_logic;
        testctrl        : in     vl_logic;
        calibrationstatus: out    vl_logic_vector(4 downto 0);
        nonusertocmu    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of lpm_type : constant is 1;
    attribute mti_svvh_generic_type of cont_cal_mode : constant is 1;
    attribute mti_svvh_generic_type of enable_rx_cal_tw : constant is 1;
    attribute mti_svvh_generic_type of enable_tx_cal_tw : constant is 1;
    attribute mti_svvh_generic_type of rtest : constant is 1;
    attribute mti_svvh_generic_type of rx_cal_wt_value : constant is 1;
    attribute mti_svvh_generic_type of send_rx_cal_status : constant is 1;
    attribute mti_svvh_generic_type of tx_cal_wt_value : constant is 1;
end cycloneiv_hssi_calibration_block;
