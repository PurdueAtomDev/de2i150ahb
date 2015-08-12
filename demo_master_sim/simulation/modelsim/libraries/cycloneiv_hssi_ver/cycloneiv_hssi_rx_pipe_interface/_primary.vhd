library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_pipe_interface is
    port(
        clk             : in     vl_logic;
        latched_p1      : in     vl_logic;
        polinv_rx       : in     vl_logic;
        polinv_rx_int   : out    vl_logic;
        rclkcmpinsertpad: in     vl_logic;
        reset_n         : in     vl_logic;
        rind_error_reporting: in     vl_logic;
        rrdwidth_rx     : in     vl_logic;
        rrx_pipe_enable : in     vl_logic;
        rx_detect_valid : in     vl_logic;
        rx_detect_valid_sync: in     vl_logic;
        rx_found        : in     vl_logic;
        rx_found_sync   : in     vl_logic;
        rxd             : in     vl_logic_vector(63 downto 0);
        rxd_ch          : out    vl_logic_vector(63 downto 0);
        rxelecidle      : out    vl_logic;
        rxelectricalidle: in     vl_logic;
        rxpolarity      : in     vl_logic;
        rxstatus        : out    vl_logic_vector(2 downto 0);
        rxvalid         : out    vl_logic;
        sigdetni        : in     vl_logic;
        txdetectrx      : in     vl_logic
    );
end cycloneiv_hssi_rx_pipe_interface;
