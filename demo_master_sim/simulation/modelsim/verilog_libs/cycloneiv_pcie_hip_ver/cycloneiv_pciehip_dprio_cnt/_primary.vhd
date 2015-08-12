library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_dprio_cnt is
    port(
        cnt_eq_0        : out    vl_logic;
        cnt_val         : in     vl_logic_vector(4 downto 0);
        ld_cnt          : in     vl_logic;
        mdc             : in     vl_logic;
        reset           : in     vl_logic
    );
end cycloneiv_pciehip_dprio_cnt;
