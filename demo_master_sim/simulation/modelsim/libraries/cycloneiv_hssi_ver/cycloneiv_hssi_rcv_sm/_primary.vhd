library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rcv_sm is
    port(
        clk_2           : in     vl_logic;
        curr_state      : out    vl_logic_vector(1 downto 0);
        dec_ctl         : in     vl_logic_vector(3 downto 0);
        dec_data        : in     vl_logic_vector(31 downto 0);
        dec_data_valid  : in     vl_logic_vector(3 downto 0);
        indv            : in     vl_logic;
        running_disp    : in     vl_logic_vector(3 downto 0);
        rx_ctl_rs       : out    vl_logic_vector(3 downto 0);
        rx_data_rs      : out    vl_logic_vector(31 downto 0);
        rx_local_fault  : out    vl_logic;
        rx_local_fault_clr: in     vl_logic;
        rxaui_s2gx_en   : in     vl_logic;
        soft_reset      : in     vl_logic;
        tx_local_fault_det: in     vl_logic;
        xs_link_status  : out    vl_logic;
        xs_link_status_set: in     vl_logic
    );
end cycloneiv_hssi_rcv_sm;
