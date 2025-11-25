library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library unisim;
use unisim.VComponents.all;

entity top_module is
    port (
        SYSCLK_P            : in std_logic;
        SYSCLK_N            : in std_logic;
        
        PMOD2_0_LS          : out std_logic;
        PMOD2_1_LS          : out std_logic;
        PMOD2_2_LS          : out std_logic;
        PMOD2_3_LS          : out std_logic;
        
        PMOD1_0_LS          : out std_logic;
        PMOD1_1_LS          : out std_logic;
        PMOD1_2_LS          : out std_logic;
        PMOD1_3_LS          : out std_logic;
        
        -- DDRs are declared at port but not in constraint.
        -- DDR configurator knows
        DDR_cas_n           : inout STD_LOGIC;
        DDR_cke             : inout STD_LOGIC;
        DDR_ck_n            : inout STD_LOGIC;
        DDR_ck_p            : inout STD_LOGIC;
        DDR_cs_n            : inout STD_LOGIC;
        DDR_reset_n         : inout STD_LOGIC;
        DDR_odt             : inout STD_LOGIC;
        DDR_ras_n           : inout STD_LOGIC;
        DDR_we_n            : inout STD_LOGIC;
        DDR_ba              : inout STD_LOGIC_VECTOR ( 2 downto 0 );
        DDR_addr            : inout STD_LOGIC_VECTOR ( 14 downto 0 );
        DDR_dm              : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dq              : inout STD_LOGIC_VECTOR ( 31 downto 0 );
        DDR_dqs_n           : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dqs_p           : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        
        -- Fixed ios are declared at port but not in constraint
        FIXED_IO_mio        : inout STD_LOGIC_VECTOR ( 53 downto 0 );
        FIXED_IO_ddr_vrn    : inout STD_LOGIC;
        FIXED_IO_ddr_vrp    : inout STD_LOGIC;
        FIXED_IO_ps_srstb   : inout STD_LOGIC;
        FIXED_IO_ps_clk     : inout STD_LOGIC;
        FIXED_IO_ps_porb    : inout STD_LOGIC
    );
end entity top_module;

architecture rtl of top_module is
    
    component arm_design_wrapper is
    port (
        DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
        DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
        DDR_cas_n : inout STD_LOGIC;
        DDR_ck_n : inout STD_LOGIC;
        DDR_ck_p : inout STD_LOGIC;
        DDR_cke : inout STD_LOGIC;
        DDR_cs_n : inout STD_LOGIC;
        DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
        DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_odt : inout STD_LOGIC;
        DDR_ras_n : inout STD_LOGIC;
        DDR_reset_n : inout STD_LOGIC;
        DDR_we_n : inout STD_LOGIC;
        FCLK_CLK0_0 : out STD_LOGIC;
        FIXED_IO_ddr_vrn : inout STD_LOGIC;
        FIXED_IO_ddr_vrp : inout STD_LOGIC;
        FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
        FIXED_IO_ps_clk : inout STD_LOGIC;
        FIXED_IO_ps_porb : inout STD_LOGIC;
        FIXED_IO_ps_srstb : inout STD_LOGIC;
        S_AXIS_S2MM_0_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
        S_AXIS_S2MM_0_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
        S_AXIS_S2MM_0_tlast : in STD_LOGIC;
        S_AXIS_S2MM_0_tready : out STD_LOGIC;
        S_AXIS_S2MM_0_tvalid : in STD_LOGIC;
        gpio_ps_in_end_time_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
        gpio_ps_in_start_time_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
        gpio_ps_out_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
        peripheral_reset_0 : out STD_LOGIC_VECTOR ( 0 to 0 )
    
    );
    end component arm_design_wrapper;

    -- Single-ended clock signal
    signal sys_clk   : std_logic;
    
    signal led_0 : std_logic := '0';
    signal led_1 : std_logic := '0';
    signal led_2 : std_logic := '0';
    signal led_3 : std_logic := '0';
    
    signal led_4 : std_logic := '0';
    signal led_5 : std_logic := '0';
    signal led_6 : std_logic := '0';
    signal led_7 : std_logic := '0';
    
    signal s_fclk                : std_logic; -- 100mhz clock
    signal S_AXIS_S2MM_0_tdata   : std_logic_vector(63 downto 0) := (others => '0');
    signal S_AXIS_S2MM_0_tkeep   : std_logic_vector(7 downto 0) := (others => '0');
    signal S_AXIS_S2MM_0_tlast   : std_logic := '0';
    signal S_AXIS_S2MM_0_tready  : std_logic := '0';
    signal S_AXIS_S2MM_0_tvalid  : std_logic := '0';
    
    signal s_ps_reset           : std_logic_vector(0 downto 0) := (others => '0'); -- active high reset generated from reset controller after zynq arm is resetted with ps_por_b
    signal s_ps_reset_n         : std_logic := '1'; -- active low system reset (derived from ps reset)
        
    signal s_gpio_sw_o          : std_logic_vector(7 downto 0) := (others => '0');
    signal s_gpio_start_time_i  : std_logic_vector(31 downto 0);
    signal s_gpio_end_time_i    : std_logic_vector(31 downto 0);

    signal cycle_counter        : unsigned(31 downto 0) := (others => '0');
    signal start_time           : unsigned(31 downto 0) := (others => '0');
    signal end_time             : unsigned(31 downto 0) := (others => '0');
    
    type s2mm_state_t is (IDLE, SEND, LAST, DONE);
    signal s2mm_state : s2mm_state_t := IDLE;
    
    signal beat_cnt : integer := 0;
    constant TOTAL_BEATS : integer := 1048576;--33554432; --1048576; -- 1048576 * 8 = 8Mbyte write gives 420 Mbtes/sec speed
    
begin
    
    s_ps_reset_n <= not s_ps_reset(0);
                       
    arm_design_i: component arm_design_wrapper
    port map (
        DDR_addr(14 downto 0)       => DDR_addr(14 downto 0),
        DDR_ba(2 downto 0)          => DDR_ba(2 downto 0),
        DDR_cas_n                   => DDR_cas_n,
        DDR_ck_n                    => DDR_ck_n,
        DDR_ck_p                    => DDR_ck_p,
        DDR_cke                     => DDR_cke,
        DDR_cs_n                    => DDR_cs_n,
        DDR_dm(3 downto 0)          => DDR_dm(3 downto 0),
        DDR_dq(31 downto 0)         => DDR_dq(31 downto 0),
        DDR_dqs_n(3 downto 0)       => DDR_dqs_n(3 downto 0),
        DDR_dqs_p(3 downto 0)       => DDR_dqs_p(3 downto 0),
        DDR_odt                     => DDR_odt,
        DDR_ras_n                   => DDR_ras_n,
        DDR_reset_n                 => DDR_reset_n,
        DDR_we_n                    => DDR_we_n,
        FIXED_IO_ddr_vrn            => FIXED_IO_ddr_vrn,
        FIXED_IO_ddr_vrp            => FIXED_IO_ddr_vrp,
        FIXED_IO_mio(53 downto 0)   => FIXED_IO_mio(53 downto 0),
        FIXED_IO_ps_clk             => FIXED_IO_ps_clk,
        FIXED_IO_ps_porb            => FIXED_IO_ps_porb,
        FIXED_IO_ps_srstb           => FIXED_IO_ps_srstb,
        FCLK_CLK0_0                 => s_fclk,
        S_AXIS_S2MM_0_tdata         => S_AXIS_S2MM_0_tdata,
        S_AXIS_S2MM_0_tkeep         => S_AXIS_S2MM_0_tkeep,
        S_AXIS_S2MM_0_tlast         => S_AXIS_S2MM_0_tlast,
        S_AXIS_S2MM_0_tready        => S_AXIS_S2MM_0_tready,
        S_AXIS_S2MM_0_tvalid        => S_AXIS_S2MM_0_tvalid,
        peripheral_reset_0          => s_ps_reset,
        gpio_ps_in_start_time_tri_i => s_gpio_start_time_i,
        gpio_ps_in_end_time_tri_i   => s_gpio_end_time_i,
        gpio_ps_out_tri_o           => s_gpio_sw_o    
    );

    ----------------------------------------------------------------------
    -- Differential clock buffer
    ----------------------------------------------------------------------
    sysclk_buf : IBUFGDS
        generic map (
            DIFF_TERM   => TRUE,      -- differential termination
            IBUF_LOW_PWR => FALSE     -- performance mode
        )
        port map (
            I  => SYSCLK_P,
            IB => SYSCLK_N,
            O  => sys_clk
        );

    ----------------------------------------------------------------------
    -- Clock divider process to blink LEDs
    ----------------------------------------------------------------------
    process(sys_clk)
    variable counter : integer range 0 to 100000000 := 0;
    begin
        if s_ps_reset_n = '0' then
            counter := 0;
            
        elsif rising_edge(sys_clk) then
            
            if counter = 5000000 then
                led_0 <= not led_0;
                led_1 <= not led_1;
                led_2 <= not led_2;
                led_3 <= not led_3;
                
                led_4 <= not led_4;
                led_5 <= not led_5;                
                
                counter := 0;
            else
                counter := counter + 1;        
            end if;
            
        end if;
        
    end process;    

    ----------------------------------------------------------------------
    -- Connect LED outputs
    ----------------------------------------------------------------------
    PMOD2_0_LS <= led_0;
    PMOD2_1_LS <= led_1;
    PMOD2_2_LS <= led_2;
    PMOD2_3_LS <= led_3;

    PMOD1_0_LS <= led_4;
    PMOD1_1_LS <= led_5;
    PMOD1_2_LS <= led_6;
    PMOD1_3_LS <= led_7;
    
    
    s_gpio_start_time_i <= std_logic_vector(start_time);
    s_gpio_end_time_i   <= std_logic_vector(end_time);

    -- There are multiple options for dma 100mhz 150mhz clock
    -- 32 bit 64 bit s2mm data width. This counter will be used to calculate clock tick to see speed
    -- Global cycle counter at S2MM clock
    process(s_fclk)
    begin
        if rising_edge(s_fclk) then
            if s_ps_reset_n = '0' then
                cycle_counter <= (others => '0');
            else
                cycle_counter <= cycle_counter + 1;
            end if;
        end if;
    end process;

    
    -- Control DMA to send data
    process(s_fclk, s_ps_reset_n)
    variable led_counter : integer range 0 to 1000000000 := 0;
    begin
        if rising_edge(s_fclk) then
            if s_ps_reset_n = '0' then
    
                s_AXIS_S2MM_0_tvalid <= '0';
                s_AXIS_S2MM_0_tlast  <= '0';
                s_AXIS_S2MM_0_tkeep  <= (others => '1');
                s_AXIS_S2MM_0_tdata  <= (others => '0');
    
                s2mm_state           <= IDLE;
                beat_cnt             <= 0;
                led_7                <= '0';
                led_counter          := 0;
    
            else
    
                case s2mm_state is
    
                    ----------------------------------------------------------------
                    -- IDLE: bus is quiet
                    ----------------------------------------------------------------
                    when IDLE =>
                        s_AXIS_S2MM_0_tvalid <= '0';
                        s_AXIS_S2MM_0_tlast  <= '0';
                        beat_cnt             <= 0;
    
                        if s_gpio_sw_o(0) = '1' then
                            -- Start automatically (can replace with condition later)
                            s2mm_state <= SEND;
                        end if;
    
                    ----------------------------------------------------------------
                    -- SEND: stream normal beats until the second-last beat
                    ----------------------------------------------------------------
                    when SEND =>
                        s_AXIS_S2MM_0_tlast <= '0';
    
                        if s_AXIS_S2MM_0_tready = '1' then
                        
                            if beat_cnt = 0 then
                                start_time <= cycle_counter;
                            end if;
                            
                            led_7 <= not led_7;

                            s_AXIS_S2MM_0_tvalid <= '1';
                            s_AXIS_S2MM_0_tdata <= std_logic_vector(to_unsigned(beat_cnt, 64));
    
                            if beat_cnt = TOTAL_BEATS - 2 then
                                beat_cnt   <= beat_cnt + 1;
                                s2mm_state <= LAST;
                            else
                                beat_cnt <= beat_cnt + 1;
                            end if;
    
                        else
                            s_AXIS_S2MM_0_tvalid <= '0';
                        end if;
    
                    ----------------------------------------------------------------
                    -- LAST: send the final beat with TLAST=1
                    ----------------------------------------------------------------
                    when LAST =>
                        s_AXIS_S2MM_0_tlast <= '1';
    
                        if s_AXIS_S2MM_0_tready = '1' then
                            s_AXIS_S2MM_0_tvalid <= '1';
                            s_AXIS_S2MM_0_tdata <= std_logic_vector(to_unsigned(beat_cnt, 64));
                            s2mm_state           <= DONE;
                            
                            end_time <= cycle_counter;
                            
                        else
                            s_AXIS_S2MM_0_tvalid <= '0';
                        end if;
                        
                        if led_counter = 100000000 then
                            led_6 <= not led_6; -- it does not stay here checked with led
                            led_counter := 0;
                        else
                            led_counter := led_counter + 1;
                        end if;
    
                    ----------------------------------------------------------------
                    -- DONE: end of burst
                    ----------------------------------------------------------------
                    when DONE =>
                        s_AXIS_S2MM_0_tvalid <= '0';
                        s_AXIS_S2MM_0_tlast  <= '0';

                        -- stay here until reset, or set <= IDLE for continuous bursts
                        
                        if led_counter = 100000000 then
                            led_7 <= not led_7;  -- code enters here no problem
                            led_counter := 0;
                        else
                            led_counter := led_counter + 1;
                        end if;
    
                end case;
    
            end if;
        end if;
    end process;

    
    

end architecture rtl;















