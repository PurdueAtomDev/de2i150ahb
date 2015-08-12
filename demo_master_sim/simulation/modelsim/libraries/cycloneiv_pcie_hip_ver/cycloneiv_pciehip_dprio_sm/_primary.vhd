library verilog;
use verilog.vl_types.all;
entity cycloneiv_pciehip_dprio_sm is
    generic(
        IDLE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        PREAMBLE        : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        CONTROL         : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        TURN_ARND_0     : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        TURN_ARND_1     : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        ADDR_DATA       : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        ADDR_OP         : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        WR_OP           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        RD_INC_OP       : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        RD_OP           : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        mdc             : in     vl_logic;
        mdio_in         : in     vl_logic;
        reset           : in     vl_logic;
        opcode          : in     vl_logic_vector(1 downto 0);
        valid_addr      : in     vl_logic;
        cnt_eq_0        : in     vl_logic;
        shift_in        : out    vl_logic;
        shift_out       : out    vl_logic;
        latch_ctl       : out    vl_logic;
        incr_addr       : out    vl_logic;
        mdio_wr         : out    vl_logic;
        mdio_rd         : out    vl_logic;
        shift_addr      : out    vl_logic;
        ld_data         : out    vl_logic;
        ld_cnt          : out    vl_logic;
        cnt_val         : out    vl_logic_vector(4 downto 0);
        valid_addr_lt   : out    vl_logic;
        curr_state      : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of PREAMBLE : constant is 1;
    attribute mti_svvh_generic_type of CONTROL : constant is 1;
    attribute mti_svvh_generic_type of TURN_ARND_0 : constant is 1;
    attribute mti_svvh_generic_type of TURN_ARND_1 : constant is 1;
    attribute mti_svvh_generic_type of ADDR_DATA : constant is 1;
    attribute mti_svvh_generic_type of ADDR_OP : constant is 1;
    attribute mti_svvh_generic_type of WR_OP : constant is 1;
    attribute mti_svvh_generic_type of RD_INC_OP : constant is 1;
    attribute mti_svvh_generic_type of RD_OP : constant is 1;
end cycloneiv_pciehip_dprio_sm;
