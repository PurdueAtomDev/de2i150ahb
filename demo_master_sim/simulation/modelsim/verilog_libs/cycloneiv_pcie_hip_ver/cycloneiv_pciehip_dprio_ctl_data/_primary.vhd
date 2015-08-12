library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_dprio_ctl_data is
    port(
        data_enable_n   : out    vl_logic;
        dev_addr        : in     vl_logic_vector(4 downto 0);
        latch_ctl       : in     vl_logic;
        ld_data         : in     vl_logic;
        mbus_in         : out    vl_logic_vector(15 downto 0);
        mbus_out        : in     vl_logic_vector(15 downto 0);
        mdc             : in     vl_logic;
        mdio_in         : in     vl_logic;
        mdio_out        : out    vl_logic;
        opcode          : out    vl_logic_vector(1 downto 0);
        port_addr       : in     vl_logic_vector(4 downto 0);
        reset           : in     vl_logic;
        shift_in        : in     vl_logic;
        shift_out       : in     vl_logic;
        valid_addr      : out    vl_logic;
        valid_addr_lt   : in     vl_logic
    );
end cycloneiv_pciehip_dprio_ctl_data;
