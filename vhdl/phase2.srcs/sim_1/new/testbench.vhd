----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/06/2018 11:06:19 AM
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

component sha is
  generic (length : integer := 31);
  Port ( msg: in unsigned(length downto 0);
          clk,rst,en: in std_logic;
          ready: out std_logic;
          final_hash: out unsigned(255 downto 0)
  );
end component;
component mining is
  Port (clk,rst,en: in std_logic;
        block_header: in unsigned (639 downto 0);
        hash: out unsigned (255 downto 0);
        finish: out std_logic
        );
end component;

signal msg: unsigned(31 downto 0);
signal rst, clk, en1, en2, ready: std_logic := '0';
signal final_hash: unsigned(255 downto 0);
signal block_header: unsigned (639 downto 0);
signal hash: unsigned(255 downto 0);
signal finish: std_logic;

begin

rst <= '1', '0' after 30 ns;--, '1' after 130 ns, '0' after 160 ns, '1' after 360 ns, '0' after 390 ns;
clk <= not(clk) after 50 ns;
en1<='1', '0' after 500 ns;

msg <= "01100001011000100110001101100100"; --abcd--"00000000011000010110001001100011"; --abc

u: sha generic map(31) port map (msg,clk,rst,en1,ready,final_hash);
block_header <= x"02000000" & x"17975b97c18ed1f7e255adf297599b55330edab87803c8170100000000000000" 
& final_hash & x"358b0553" & x"5350f119" & x"00000000";
l: mining  port map ( clk,rst,ready, block_header, hash, finish);
end Behavioral;
