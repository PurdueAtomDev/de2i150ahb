library verilog;
use verilog.vl_types.all;
entity user_logic is
    generic(
        ADDRESSWIDTH    : integer := 32;
        DATAWIDTH       : integer := 32;
        BYTEENABLEWIDTH : integer := 4;
        NUMREGS         : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        data            : in     vl_logic_vector;
        data_addr       : out    vl_logic_vector;
        r_fifo_read_enable: out    vl_logic;
        r_fifo_read_data: in     vl_logic_vector;
        r_fifo_empty    : in     vl_logic;
        add_data_sel    : in     vl_logic;
        rdwr_address    : in     vl_logic_vector(15 downto 0);
        display_data    : out    vl_logic_vector;
        write_control_done: in     vl_logic;
        write_abort     : in     vl_logic;
        write_control_fixed_location: out    vl_logic;
        write_control_write_base: out    vl_logic_vector;
        write_control_write_length: out    vl_logic_vector;
        write_control_go: out    vl_logic;
        write_data_size : out    vl_logic_vector(2 downto 0);
        write_user_write_buffer: out    vl_logic;
        write_user_buffer_data: out    vl_logic_vector;
        write_user_buffer_full: in     vl_logic;
        read_control_done: in     vl_logic;
        read_control_fixed_location: out    vl_logic;
        read_control_read_base: out    vl_logic_vector;
        read_control_read_length: out    vl_logic_vector;
        read_control_go : out    vl_logic;
        read_abort      : in     vl_logic;
        read_data_size  : out    vl_logic_vector(2 downto 0);
        read_user_read_buffer: out    vl_logic;
        read_user_buffer_data: in     vl_logic_vector;
        read_user_data_available: in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDRESSWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATAWIDTH : constant is 1;
    attribute mti_svvh_generic_type of BYTEENABLEWIDTH : constant is 1;
    attribute mti_svvh_generic_type of NUMREGS : constant is 1;
end user_logic;
