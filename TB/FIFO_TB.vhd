----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2025 08:45:55 PM
-- Design Name: 
-- Module Name: FIFO_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIFO_TB is
--  Port ( );
end FIFO_TB;

architecture Behavioral of FIFO_TB is

    component fifo_generator_0
      PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        full : OUT STD_LOGIC;
        almost_full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC;
        rd_data_count : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        wr_data_count : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
      );
    END component;
    signal clk : std_logic := '0';
    signal srst : std_logic := '1';

    signal din   : std_logic_vector(7 downto 0) := (others => '0');
    signal wr_en : std_logic := '0';
    signal rd_en : STD_LOGIC := '0';
    signal dout :  STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
    signal full :  STD_LOGIC := '0';
    signal almost_full : STD_LOGIC := '0';
    signal empty : STD_LOGIC := '0';
    signal rd_data_count : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
    signal wr_data_count : STD_LOGIC_VECTOR(5 DOWNTO 0) := (others => '0');
    signal count_wr : unsigned(6 downto 0) := (others=> '0');

begin
    UUT : fifo_generator_0
        port map(
            clk => clk,
            srst => srst,
            din => din,
            wr_en => wr_en,
            rd_en => rd_en,
            dout => dout,
            full => full,
            almost_full => almost_full,
            empty => empty,
            rd_data_count => rd_data_count,
            wr_data_count => wr_data_count
        );
        
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait; -- stop process
    end process;
    
    fifo_process : process
        begin
         -- Reset
        srst <= '1';
        wr_en <= '0';
        rd_en <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        srst <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        for i in 0 to 29 loop
            din <= std_logic_vector(to_unsigned(i, 8));
            wr_en <= '1';
            count_wr <= count_wr + 1;
            wait until rising_edge(clk);
        end loop;
        
        wr_en <= '0';
--        rd_en <= '1';
--        count_wr <= count_wr - 2;

--        wait until rising_edge(clk);
--        rd_en <= '0';

--        for i in 0 to 1 loop
--            din <= std_logic_vector(to_unsigned(i, 8));
--            wr_en <= '1';
--            count_wr <= count_wr + 1;
--            wait until rising_edge(clk);
--        end loop;
        
--        wr_en <= '0';
        wait;
    end process;



end Behavioral;
