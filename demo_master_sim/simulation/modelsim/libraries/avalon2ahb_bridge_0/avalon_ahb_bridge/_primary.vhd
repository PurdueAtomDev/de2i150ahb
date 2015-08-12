library verilog;
use verilog.vl_types.all;
entity avalon_ahb_bridge is
    generic(
        AVALON_ADDRESSWIDTH: integer := 5;
        ADDRESSWIDTH    : integer := 32;
        DATAWIDTH       : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        address         : in     vl_logic_vector;
        write           : in     vl_logic;
        read            : in     vl_logic;
        writedata       : in     vl_logic_vector;
        waitrequest     : out    vl_logic;
        readdatavalid   : out    vl_logic;
        readdata        : out    vl_logic_vector;
        HRDATA          : in     vl_logic_vector;
        HREADY          : in     vl_logic;
        HRESP           : in     vl_logic_vector(1 downto 0);
        HBURST          : out    vl_logic_vector(2 downto 0);
        HSIZE           : out    vl_logic_vector(2 downto 0);
        HTRANS          : out    vl_logic_vector(1 downto 0);
        HSEL            : out    vl_logic;
        HPROT           : out    vl_logic_vector(3 downto 0);
        HADDR           : out    vl_logic_vector;
        HWDATA          : out    vl_logic_vector;
        HWRITE          : out    vl_logic;
        HREADYIN        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of AVALON_ADDRESSWIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDRESSWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATAWIDTH : constant is 1;
end avalon_ahb_bridge;
