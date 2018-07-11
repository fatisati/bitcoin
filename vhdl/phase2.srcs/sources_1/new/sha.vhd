----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2018 10:00:39 AM
-- Design Name: 
-- Module Name: sha - Behavioral
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

entity sha is
       generic (length : integer := 31);
  Port ( msg: in unsigned(length downto 0);
          clk,rst,en1,en2: in std_logic;
          ready: out std_logic;
          final_hash: out unsigned(255 downto 0)
  );
end sha;

architecture Behavioral of sha is
component expansion_perm is
  generic (length : integer := 31);
  Port (msg: in unsigned(length downto 0);
        clk: in std_logic;
        w1: out arr2d := (others => (others => '0'));
        w2: out arr2d := (others => (others => '0'));
        two_block: out std_logic := '0'
         );
end component;

component compression is
  Port (w, k: in  arr2d; 
        hi: in arr8_31;
        rst, clk, en: in std_logic;
        hash: out arr8_31;
        finish: out std_logic := '0'
        );
end component;


signal two_block: std_logic := '0';

signal w1, w2, k:  arr2d; 
signal hi: arr8_31;
signal hash1, hash2: arr8_31;
signal finish1,finish2: std_logic;
begin

hi(0) <= x"6a09e667";
hi(1) <= x"bb67ae85";
hi(2) <= x"3c6ef372";
hi(3) <= x"a54ff53a";
hi(4) <= x"510e527f";
hi(5) <= x"9b05688c";
hi(6) <= x"1f83d9ab";
hi(7) <= x"5be0cd19";

k(0)  <= x"428a2f98";
k(1)  <= x"71374491";
k(2)  <= x"b5c0fbcf";
k(3)  <= x"e9b5dba5";
k(4)  <= x"3956c25b";
k(5)  <= x"59f111f1";
k(6)  <= x"923f82a4";
k(7)  <= x"ab1c5ed5";
k(8)  <= x"d807aa98";
k(9)  <= x"12835b01";
k(10) <= x"243185be";
k(11) <= x"550c7dc3";
k(12) <= x"72be5d74";
k(13) <= x"80deb1fe";
k(14) <= x"9bdc06a7";
k(15) <= x"c19bf174";
k(16) <= x"e49b69c1";
k(17) <= x"efbe4786";
k(18) <= x"0fc19dc6";
k(19) <= x"240ca1cc";
k(20) <= x"2de92c6f";
k(21) <= x"4a7484aa";
k(22) <= x"5cb0a9dc";
k(23) <= x"76f988da";
k(24) <= x"983e5152";
k(25) <= x"a831c66c";
k(26) <= x"b00327c8";
k(27) <= x"bf597fc7";
k(28) <= x"c6e00bf3";
k(29) <= x"d5a79147";
k(30) <= x"06ca6351";
k(31) <= x"14292967";
k(32) <= x"27b70a85";
k(33) <= x"2e1b2138";
k(34) <= x"4d2c6dfc";
k(35) <= x"53380d13";
k(36) <= x"650a7354";
k(37) <= x"766a0abb";
k(38) <= x"81c2c92e";
k(39) <= x"92722c85";
k(40) <= x"a2bfe8a1";
k(41) <= x"a81a664b";
k(42) <= x"c24b8b70";
k(43) <= x"c76c51a3";
k(44) <= x"d192e819";
k(45) <= x"d6990624";
k(46) <= x"f40e3585";
k(47) <= x"106aa070";
k(48) <= x"19a4c116";
k(49) <= x"1e376c08";
k(50) <= x"2748774c";
k(51) <= x"34b0bcb5";
k(52) <= x"391c0cb3";
k(53) <= x"4ed8aa4a";
k(54) <= x"5b9cca4f";
k(55) <= x"682e6ff3";
k(56) <= x"748f82ee";
k(57) <= x"78a5636f";
k(58) <= x"84c87814";
k(59) <= x"8cc70208";
k(60) <= x"90befffa";
k(61) <= x"a4506ceb";
k(62) <= x"be49a3f7";
k(63) <= x"c67178f2";


u: expansion_perm generic map(length) port map (msg,clk, w1, w2, two_block);

l0: compression port map(w1, k, hi, rst, clk, en1,  hash1, finish1);
l2: compression port map(w2, k, hash1, rst, clk, en2, hash2, finish2);

final_hash <= (hash1(0) & hash1(1)&hash1(2)&hash1(3)&hash1(4)&hash1(5)&hash1(6)&hash1(7)) when(two_block='0')
                else (hash2(0)&hash2(1)&hash2(2)&hash2(3)&hash2(4)&hash2(5)&hash2(6)&hash2(7));
ready <= finish1 when(two_block='0')  
                 else finish2;  
end Behavioral;