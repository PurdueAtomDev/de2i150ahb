library verilog;
use verilog.vl_types.all;
entity ahb_avalon_bridge_with_burst is
    generic(
        ADDRESSWIDTH    : integer := 32;
        DATAWIDTH       : integer := 32;
        FIFODEPTH       : integer := 32;
        FIFODEPTH_LOG   : integer := 5;
        MAXBURSTCOUNT   : integer := 8
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        address         : out    vl_logic_vector;
        write           : out    vl_logic;
        read            : out    vl_logic;
        byteenable      : out    vl_logic_vector(3 downto 0);
        writedata       : out    vl_logic_vector;
        waitrequest     : in     vl_logic;
        readdatavalid   : in     vl_logic;
        readdata        : in     vl_logic_vector;
        burstcount      : out    vl_logic_vector(3 downto 0);
        HRDATA          : out    vl_logic_vector;
        HREADY          : in     vl_logic;
        HRESP           : out    vl_logic_vector(1 downto 0);
        HBURST          : in     vl_logic_vector(2 downto 0);
        HSIZE           : in     vl_logic_vector(2 downto 0);
        HTRANS          : in     vl_logic_vector(1 downto 0);
        HPROT           : in     vl_logic_vector(3 downto 0);
        HADDR           : in     vl_logic_vector;
        HWDATA          : in     vl_logic_vector;
        HWRITE          : in     vl_logic;
        HREADYOUT       : out    vl_logic;
        HSEL            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDRESSWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATAWIDTH : constant is 1;
    attribute mti_svvh_generic_type of FIFODEPTH : constant is 1;
    attribute mti_svvh_generic_type of FIFODEPTH_LOG : constant is 1;
    attribute mti_svvh_generic_type of MAXBURSTCOUNT : constant is 1;
end ahb_avalon_bridge_with_burst;
