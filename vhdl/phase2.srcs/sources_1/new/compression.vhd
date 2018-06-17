----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2018 01:41:33 PM
-- Design Name: 
-- Module Name: compression - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
package pkg is
        type arr2d is array (62 downto 0) of unsigned(31 downto 0);
end pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg.all;
use ieee.numeric_std.all;
entity compression is
  Port (w, k: in  arr2d; 
        hash: out unsigned(255 downto 0)
        );
end compression;

architecture Behavioral of compression is

signal a  : unsigned(31 downto 0) := x"6a09e667";
signal B  : unsigned(31 downto 0) := x"bb67ae85";
signal C  : unsigned(31 downto 0) := x"3c6ef372";
signal D  : unsigned(31 downto 0) := x"a54ff53a";
signal Ee : unsigned(31 downto 0) := x"510e527f";
signal F  : unsigned(31 downto 0) := x"9b05688c";
signal G  : unsigned(31 downto 0) := x"1f83d9ab";
signal H  : unsigned(31 downto 0) := x"5be0cd19";
 
begin


end Behavioral;
