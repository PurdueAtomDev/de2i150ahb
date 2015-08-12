library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_dskw_sm is
    port(
        align_det_sync  : in     vl_logic_vector(7 downto 0);
        align_status    : out    vl_logic;
        clk_1           : in     vl_logic;
        curr_state      : out    vl_logic_vector(3 downto 0);
        enable_deskew   : out    vl_logic;
        fifo_reset_rd   : out    vl_logic;
        octal_mode      : in     vl_logic;
        rd_align        : in     vl_logic_vector(7 downto 0);
        soft_reset      : in     vl_logic;
        sync_status     : in     vl_logic_vector(7 downto 0)
    );
end cycloneiv_hssi_dskw_sm;
