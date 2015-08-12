library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_eii_module is
    port(
        eidleinfersel   : in     vl_logic_vector(2 downto 0);
        eiosdetect_int  : in     vl_logic;
        gen2ngen1       : in     vl_logic;
        gen2ngen1_bundle: in     vl_logic;
        inferred_rxvalid: in     vl_logic;
        kcount          : in     vl_logic_vector(1 downto 0);
        kflag           : in     vl_logic;
        pipe_loopbk     : in     vl_logic;
        rcvd_clk        : in     vl_logic;
        reidle_com_detect: in     vl_logic_vector(1 downto 0);
        reidleinferenable: in     vl_logic;
        rgen1_sigdet_ena: in     vl_logic;
        riei_eios_priority_dis: in     vl_logic;
        rindv_rx        : in     vl_logic;
        rwait_count     : in     vl_logic_vector(7 downto 0);
        rxelecidle_int  : out    vl_logic;
        rxpcsrst        : in     vl_logic;
        signaldetect    : in     vl_logic;
        skposdetect     : in     vl_logic;
        sudi            : in     vl_logic_vector(15 downto 0);
        syncstatus      : in     vl_logic
    );
end cycloneiv_hssi_rx_digi_eii_module;
