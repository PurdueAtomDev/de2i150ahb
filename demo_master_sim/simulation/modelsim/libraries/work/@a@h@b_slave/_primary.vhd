library verilog;
use verilog.vl_types.all;
entity AHB_slave is
    generic(
        ADDRESSWIDTH    : integer := 32;
        DATAWIDTH       : integer := 32;
        NUMREGS         : integer := 32;
        REGWIDTH        : integer := 32;
        FIFO_DEPTH      : integer := 64;
        FIFO_DEPTH_LOG2 : integer := 6
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        HSEL            : in     vl_logic;
        HADDR           : in     vl_logic_vector;
        HWRITE          : in     vl_logic;
        HSIZE           : in     vl_logic_vector(2 downto 0);
        HBURST          : in     vl_logic_vector(2 downto 0);
        HPROT           : in     vl_logic_vector(3 downto 0);
        HTRANS          : in     vl_logic_vector(1 downto 0);
        HREADY          : in     vl_logic;
        HWDATA          : in     vl_logic_vector;
        HREADYOUT       : out    vl_logic;
        HRESP           : out    vl_logic_vector(1 downto 0);
        HRDATA          : out    vl_logic_vector;
        w_fifo_write_enable: in     vl_logic;
        w_fifo_write_data: in     vl_logic_vector;
        w_fifo_full     : out    vl_logic;
        r_fifo_read_enable: in     vl_logic;
        r_fifo_read_data: out    vl_logic_vector;
        r_fifo_empty    : out    vl_logic;
        u_addr          : in     vl_logic_vector;
        u_read_data     : out    vl_logic_vector;
        u_write         : in     vl_logic;
        u_write_data    : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDRESSWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATAWIDTH : constant is 1;
    attribute mti_svvh_generic_type of NUMREGS : constant is 1;
    attribute mti_svvh_generic_type of REGWIDTH : constant is 1;
    attribute mti_svvh_generic_type of FIFO_DEPTH : constant is 1;
    attribute mti_svvh_generic_type of FIFO_DEPTH_LOG2 : constant is 1;
end AHB_slave;
