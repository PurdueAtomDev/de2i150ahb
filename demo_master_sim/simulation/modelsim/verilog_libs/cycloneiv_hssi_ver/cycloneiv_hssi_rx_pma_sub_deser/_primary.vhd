library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_pma_sub_deser is
    generic(
        channel_width   : integer := 8
    );
    port(
        fclk            : in     vl_logic;
        deven           : in     vl_logic;
        dodd            : in     vl_logic;
        loaden          : in     vl_logic;
        clr             : in     vl_logic;
        rxdat           : out    vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of channel_width : constant is 1;
end cycloneiv_hssi_rx_pma_sub_deser;
