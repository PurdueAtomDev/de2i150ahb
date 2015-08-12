library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_iei_detect is
    port(
        datain_ch0      : in     vl_logic_vector(8 downto 0);
        datain_ch1      : in     vl_logic_vector(8 downto 0);
        datain_ch2      : in     vl_logic_vector(8 downto 0);
        datain_ch3      : in     vl_logic_vector(8 downto 0);
        datain_ch4      : in     vl_logic_vector(8 downto 0);
        datain_ch5      : in     vl_logic_vector(8 downto 0);
        datain_ch6      : in     vl_logic_vector(8 downto 0);
        datain_ch7      : in     vl_logic_vector(8 downto 0);
        eidleinfersel   : in     vl_logic_vector(2 downto 0);
        enable_inf_ei   : in     vl_logic_vector(5 downto 0);
        pclk            : in     vl_logic;
        prstn           : in     vl_logic;
        rate            : in     vl_logic;
        rxelecidle      : out    vl_logic_vector(7 downto 0);
        rxelecidle_in   : in     vl_logic_vector(7 downto 0);
        rxupdatefc      : in     vl_logic;
        rxvalid         : in     vl_logic_vector(7 downto 0);
        test_in_0       : in     vl_logic;
        uclk            : in     vl_logic;
        urstn           : in     vl_logic
    );
end cycloneiv_pciehip_iei_detect;
