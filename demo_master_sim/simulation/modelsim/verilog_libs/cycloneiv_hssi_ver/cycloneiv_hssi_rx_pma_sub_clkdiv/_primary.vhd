library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_pma_sub_clkdiv is
    port(
        rxfclk          : in     vl_logic;
        clr             : in     vl_logic;
        deser_fact      : in     vl_logic_vector(3 downto 0);
        loaden          : out    vl_logic;
        clkdivrx        : out    vl_logic
    );
end cycloneiv_hssi_rx_pma_sub_clkdiv;
