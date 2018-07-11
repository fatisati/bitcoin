----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2018 10:32:40 PM
-- Design Name: 
-- Module Name: pack - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
package pack is
procedure decToBinary (n: in integer; 
                       binaryNum: in unsigned(63 downto 0));                
end pack;

package body pack is
    procedure decToBinary (n: in integer; 
                           binaryNum: in unsigned(63 downto 0)) is
     variable i: integer := 0;
     variable nVar: integer := n;
     
     begin
        while (nVar > 0) loop
            binaryNum(i) <= (nVar - (nVar/2)*2);
            nVar := nVar / 2;
            i := i+1;
        end loop;
     end decToBinary;
end pack;