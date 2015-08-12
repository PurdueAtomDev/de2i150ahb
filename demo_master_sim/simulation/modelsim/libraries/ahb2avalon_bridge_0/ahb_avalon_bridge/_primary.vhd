library verilog;
use verilog.vl_types.all;
entity ahb_avalon_bridge is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        address         : out    vl_logic_vector(31 downto 0);
        write           : out    vl_logic;
        read            : out    vl_logic;
        writedata       : out    vl_logic_vector(31 downto 0);
        waitrequest     : in     vl_logic;
        readdatavalid   : in     vl_logic;
        readdata        : in     vl_logic_vector(31 downto 0);
        HRDATA          : out    vl_logic_vector(31 downto 0);
        HREADY          : in     vl_logic;
        HRESP           : out    vl_logic_vector(1 downto 0);
        HBURST          : in     vl_logic_vector(2 downto 0);
        HSIZE           : in     vl_logic_vector(2 downto 0);
        HTRANS          : in     vl_logic_vector(1 downto 0);
        HPROT           : in     vl_logic_vector(3 downto 0);
        HADDR           : in     vl_logic_vector(31 downto 0);
        HWDATA          : in     vl_logic_vector(31 downto 0);
        HWRITE          : in     vl_logic;
        HREADYOUT       : out    vl_logic;
        HSEL            : in     vl_logic
    );
end ahb_avalon_bridge;
