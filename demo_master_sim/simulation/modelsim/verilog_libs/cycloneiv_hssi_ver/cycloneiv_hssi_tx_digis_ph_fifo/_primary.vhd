library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_tx_digis_ph_fifo is
    port(
        rst_wclk        : in     vl_logic;
        rst_rclk        : in     vl_logic;
        wr_clk          : in     vl_logic;
        rd_clk          : in     vl_logic;
        bypass_en       : in     vl_logic;
        lowlatency_en   : in     vl_logic;
        we              : in     vl_logic;
        re              : in     vl_logic;
        din             : in     vl_logic_vector(53 downto 0);
        rphfifo_regmode_tx: in     vl_logic;
        rindv_tx        : in     vl_logic;
        rauto_speed_ena : in     vl_logic;
        reset_pc_ptrs   : in     vl_logic;
        reset_pc_ptrs_centrl: in     vl_logic;
        reset_pc_ptrs_quad_up: in     vl_logic;
        reset_pc_ptrs_quad_down: in     vl_logic;
        rmaster_tx      : in     vl_logic;
        rmaster_up_tx   : in     vl_logic;
        data_out        : out    vl_logic_vector(53 downto 0);
        ph_fifo_full    : out    vl_logic;
        ph_fifo_empty   : out    vl_logic;
        wptr_bin        : out    vl_logic_vector(2 downto 0);
        rptr_bin        : out    vl_logic_vector(2 downto 0)
    );
end cycloneiv_hssi_tx_digis_ph_fifo;
