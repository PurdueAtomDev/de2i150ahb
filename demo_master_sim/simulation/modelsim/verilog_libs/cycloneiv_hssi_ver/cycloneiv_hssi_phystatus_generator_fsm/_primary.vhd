library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_phystatus_generator_fsm is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        phystat_ena     : in     vl_logic;
        rphystatus_rst_toggle: in     vl_logic;
        powerdown       : in     vl_logic_vector(1 downto 0);
        phystatus       : out    vl_logic;
        rindv_rx        : in     vl_logic;
        rmaster_rx      : in     vl_logic;
        rmaster_up_rx   : in     vl_logic;
        speed_change    : in     vl_logic;
        speed_change_centrl: in     vl_logic;
        speed_change_quad_up: in     vl_logic;
        speed_change_quad_down: in     vl_logic;
        rx_detect_valid : in     vl_logic;
        power_state_transition_done: in     vl_logic;
        power_state_transition_done_ena: in     vl_logic;
        p1              : in     vl_logic;
        internal_done   : in     vl_logic
    );
end cycloneiv_hssi_phystatus_generator_fsm;
