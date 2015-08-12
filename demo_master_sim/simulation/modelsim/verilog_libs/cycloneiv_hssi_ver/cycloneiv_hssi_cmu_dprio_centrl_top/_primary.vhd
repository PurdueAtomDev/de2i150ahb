library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_cmu_dprio_centrl_top is
    port(
        mdio_rst        : in     vl_logic;
        mdio_wr         : in     vl_logic;
        reg_addr        : in     vl_logic_vector(15 downto 0);
        mdc             : in     vl_logic;
        mbus_in         : in     vl_logic_vector(15 downto 0);
        serial_mode     : in     vl_logic;
        mdio_dis        : in     vl_logic;
        pma_cram_test   : in     vl_logic;
        ser_shift_load  : in     vl_logic;
        si              : in     vl_logic;
        csr_centrl_in   : in     vl_logic_vector(703 downto 0);
        csr_centrl_in_reserved: in     vl_logic_vector(31 downto 0);
        dp_centrl_out   : out    vl_logic_vector(703 downto 0);
        dp_centrl_out_reserved: out    vl_logic_vector(31 downto 0);
        so              : out    vl_logic;
        mbus_out        : out    vl_logic_vector(15 downto 0)
    );
end cycloneiv_hssi_cmu_dprio_centrl_top;
