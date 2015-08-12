library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digis_ram16x14_syn is
    generic(
        read_access_time: integer := 0;
        write_access_time: integer := 0;
        ram_width       : integer := 14
    );
    port(
        clk             : in     vl_logic;
        rst_l           : in     vl_logic;
        addr_wr         : in     vl_logic_vector(15 downto 0);
        addr_rd1        : in     vl_logic_vector(15 downto 0);
        addr_rd2        : in     vl_logic_vector(15 downto 0);
        data_in         : in     vl_logic_vector(13 downto 0);
        we              : in     vl_logic;
        re_l            : in     vl_logic;
        data_out1       : out    vl_logic_vector(13 downto 0);
        data_out2       : out    vl_logic_vector(13 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of read_access_time : constant is 1;
    attribute mti_svvh_generic_type of write_access_time : constant is 1;
    attribute mti_svvh_generic_type of ram_width : constant is 1;
end cycloneiv_hssi_rx_digis_ram16x14_syn;
