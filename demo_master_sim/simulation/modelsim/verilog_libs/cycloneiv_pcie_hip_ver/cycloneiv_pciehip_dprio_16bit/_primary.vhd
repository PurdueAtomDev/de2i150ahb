library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_dprio_16bit is
    port(
        reset           : in     vl_logic;
        mdio_wr         : in     vl_logic;
        reg_addr        : in     vl_logic_vector(15 downto 0);
        target_addr     : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        sig_in          : in     vl_logic_vector(15 downto 0);
        ext_in          : in     vl_logic_vector(15 downto 0);
        serial_mode     : in     vl_logic;
        si              : in     vl_logic;
        shift           : in     vl_logic;
        mdio_dis        : in     vl_logic;
        sig_out         : out    vl_logic_vector(15 downto 0);
        so              : out    vl_logic
    );
end cycloneiv_pciehip_dprio_16bit;
