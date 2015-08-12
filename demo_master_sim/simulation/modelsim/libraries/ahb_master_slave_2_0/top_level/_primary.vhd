library verilog;
use verilog.vl_types.all;
entity top_level is
    port(
        HCLK            : in     vl_logic;
        HRESETn         : in     vl_logic;
        slave_HADDR     : in     vl_logic_vector(31 downto 0);
        slave_HBURST    : in     vl_logic_vector(2 downto 0);
        slave_HPROT     : in     vl_logic_vector(3 downto 0);
        slave_HSIZE     : in     vl_logic_vector(2 downto 0);
        slave_HTRANS    : in     vl_logic_vector(1 downto 0);
        slave_HWDATA    : in     vl_logic_vector(31 downto 0);
        slave_HWRITE    : in     vl_logic;
        slave_HRDATA    : out    vl_logic_vector(31 downto 0);
        slave_HREADYOUT : out    vl_logic;
        slave_HRESP     : out    vl_logic_vector(1 downto 0);
        slave_HSEL      : in     vl_logic;
        slave_HREADY    : in     vl_logic;
        master_HADDR    : out    vl_logic_vector(31 downto 0);
        master_HBURST   : out    vl_logic_vector(2 downto 0);
        master_HPROT    : out    vl_logic_vector(3 downto 0);
        master_HSIZE    : out    vl_logic_vector(2 downto 0);
        master_HTRANS   : out    vl_logic_vector(1 downto 0);
        master_HWDATA   : out    vl_logic_vector(31 downto 0);
        master_HWRITE   : out    vl_logic;
        master_HRDATA   : in     vl_logic_vector(31 downto 0);
        master_HREADY   : in     vl_logic;
        master_HRESP    : in     vl_logic_vector(1 downto 0);
        master_HREADYIN : out    vl_logic;
        master_HSEL     : out    vl_logic;
        add_data_sel    : in     vl_logic;
        rdwr_address    : in     vl_logic_vector(15 downto 0);
        display_data    : out    vl_logic_vector(31 downto 0)
    );
end top_level;
