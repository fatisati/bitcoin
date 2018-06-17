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
        type arr2d is array (63 downto 0) of unsigned(31 downto 0);
end pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg.all;
use ieee.numeric_std.all;

entity compression is
  Port (w, k: in  arr2d; 
        rst: in std_logic;
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

function ch (x, y, z : unsigned(31 downto 0) ) return unsigned is
	variable t1: unsigned(31 downto 0);
	variable t2: unsigned(31 downto 0);
	variable t3: unsigned(31 downto 0);
begin
    t1 := x and y;
    t2 := not(y) and z;
    t3 := not(x) and z;
	return t1 xor t2 xor t3;
end ch;

function maj (x, y, z : unsigned(31 downto 0) ) return unsigned is
	variable t1: unsigned(31 downto 0);
	variable t2: unsigned(31 downto 0);
	variable t3: unsigned(31 downto 0);
begin
    t1 := x and z;
    t2 := x and y;
    t3 := y and z;
	return t1 xor t2 xor t3;
end maj;


function sigma0 (x : unsigned(31 downto 0) ) return unsigned is
	variable t1: unsigned(31 downto 0);
	variable t2: unsigned(31 downto 0);
	variable t3: unsigned(31 downto 0);
	variable t4: unsigned(31 downto 0);
begin
    t1 := x ror 2;
    t2 := x ror 13;
    t3 := x ror 22;
    t4 := x srl 7;
	return t1 xor t2 xor t3 xor t4;
end sigma0;

function sigma1 (x : unsigned(31 downto 0) ) return unsigned is
	variable t1: unsigned(31 downto 0);
	variable t2: unsigned(31 downto 0);
	variable t3: unsigned(31 downto 0);
begin
    t1 := x ror 6;
    t2 := x ror 11;
    t3 := x ror 25;
	return t1 xor t2 xor t3;
end sigma1;

function sigma2 (x : unsigned(31 downto 0) ) return unsigned is
	variable t1: unsigned(31 downto 0);
	variable t2: unsigned(31 downto 0);
	variable t3: unsigned(31 downto 0);
	variable t4: unsigned(31 downto 0);
begin
    t1 := x ror 2;
    t2 := x ror 3;
    t3 := x ror 15;
    t4 := x srl 5;
	return t1 xor t2 xor t3 xor t4;
end sigma2;

signal t1, t2 : unsigned(31 downto 0);
begin

process(rst)
begin
    if(rst = '1')then
        for t in 0 to 63 loop
            t2 <= h + sigma1(ee) + ch(ee, f, g) + k(t) + w(t);
            t1 <= sigma0(a) + maj(a,b,c) + sigma2(c+d);
            h <= g;
            f <= ee;
            d <= c;
            b <= a;
            g <= f;
            ee <= d + t1;
            c <= b;
            a <= t1 + t1 + t1 - t2;
        end loop;
    end if;
end process;


end Behavioral;
