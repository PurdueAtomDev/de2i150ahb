library verilog;
use verilog.vl_types.all;
entity cycloneiv_hssi_rx_digi_freqdet is
    port(
        eidle_exit      : in     vl_logic;
        fref            : in     vl_logic;
        freq_lock       : out    vl_logic;
        fvcobyn         : in     vl_logic;
        gen2ngen1_bundle: in     vl_logic;
        gen2ngen1_indv  : in     vl_logic;
        hard_reset      : in     vl_logic;
        pd              : in     vl_logic;
        ppm_cnt_latch   : out    vl_logic_vector(7 downto 0);
        ppm_cnt_reset   : in     vl_logic;
        ppmsel          : in     vl_logic_vector(5 downto 0);
        rauto_speed_ena : in     vl_logic;
        rforcehigh      : in     vl_logic;
        rforcelow       : in     vl_logic;
        rindv_rx        : in     vl_logic;
        rppm_gen1_2xcnt_en: in     vl_logic;
        rppm_post_eidle_del: in     vl_logic;
        scan_mode       : in     vl_logic
    );
end cycloneiv_hssi_rx_digi_freqdet;
