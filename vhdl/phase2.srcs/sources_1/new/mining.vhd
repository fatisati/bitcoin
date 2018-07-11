----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2018 10:14:03 AM
-- Design Name: 
-- Module Name: mining - Behavioral
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
use work.pkg.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mining is
  Port (clk,rst,en1,en2: in std_logic;
        block_header: in unsigned (639 downto 0);
        hash: out unsigned (255 downto 0);
        finish: out std_logic
        );
end mining;

architecture Behavioral of mining is
component sha is
  generic (length : integer := 31);
  Port ( msg: in unsigned(length downto 0);
          clk,rst,en1,en2: in std_logic;
          ready: out std_logic;
          final_hash: out unsigned(255 downto 0)
  );
end component;
signal nonce: unsigned(639 downto 0):= (others => '0');
signal target: unsigned (255 downto 0):= x"1010101010101010101010101010101010101010101010101010101010101010";
signal ready,ready1, comprst, finishs:std_logic:= '0';
signal final_hash, final_hash1: unsigned(255 downto 0):= (others => '1');
begin 
u: sha generic map (639) port map (nonce+block_header, clk,comprst,en1,en2, ready, final_hash);
u2: sha generic map (255) port map (final_hash, clk,comprst,en1,en2, ready1, final_hash1);
process(ready1)
begin
    if(ready1 = '1') then
        if(final_hash1 > target and finishs /= '1')then
            nonce <= nonce +1;
            comprst <= '1';
        else
            finishs <= '0';
        end if;
    else
        comprst <= '0';
    end if;
end process;
finish <= finishs;
hash<=final_hash;
end Behavioral;
