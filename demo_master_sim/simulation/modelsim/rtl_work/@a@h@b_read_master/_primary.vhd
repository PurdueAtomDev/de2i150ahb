library verilog;
use verilog.vl_types.all;
entity AHB_read_master is
    generic(
        ADDRESSWIDTH    : integer := 32;
        DATAWIDTH       : integer := 32;
        FIFODEPTH       : integer := 32;
        FIFODEPTH_LOG   : integer := 5
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        control_fixed_location: in     vl_logic;
        control_read_base: in     vl_logic_vector;
        control_read_length: in     vl_logic_vector;
        control_go      : in     vl_logic;
        control_done    : out    vl_logic;
        abort           : out    vl_logic;
        data_size       : in     vl_logic_vector(2 downto 0);
        user_read_buffer: in     vl_logic;
        user_buffer_data: out    vl_logic_vector;
        user_data_available: out    vl_logic;
        HSEL            : out    vl_logic;
        HREADY          : in     vl_logic;
        HRESP           : in     vl_logic_vector(1 downto 0);
        HRDATA          : in     vl_logic_vector;
        HADDR           : out    vl_logic_vector;
        HWRITE          : out    vl_logic;
        HSIZE           : out    vl_logic_vector(2 downto 0);
        HBURST          : out    vl_logic_vector(2 downto 0);
        HPROT           : out    vl_logic_vector(3 downto 0);
        HTRANS          : out    vl_logic_vector(1 downto 0);
        HREADYIN        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDRESSWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATAWIDTH : constant is 1;
    attribute mti_svvh_generic_type of FIFODEPTH : constant is 1;
    attribute mti_svvh_generic_type of FIFODEPTH_LOG : constant is 1;
end AHB_read_master;
