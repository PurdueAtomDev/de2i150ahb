library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_sm is
    port(
        curr_state      : out    vl_logic_vector(3 downto 0);
        indv            : in     vl_logic;
        rd_enable_sync  : in     vl_logic;
        rxaui_s2gx_en   : in     vl_logic;
        sm_ctl          : out    vl_logic_vector(3 downto 0);
        sm_data         : out    vl_logic_vector(31 downto 0);
        soft_reset      : in     vl_logic;
        tx_clk          : in     vl_logic;
        tx_ctl          : in     vl_logic_vector(3 downto 0);
        tx_data         : in     vl_logic_vector(31 downto 0);
        tx_local_fault  : out    vl_logic;
        tx_local_fault_clr: in     vl_logic;
        tx_local_fault_det: out    vl_logic
    );
end cycloneiv_hssi_tx_sm;
