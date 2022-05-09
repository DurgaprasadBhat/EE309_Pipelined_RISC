library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity ALU is 
port(operand1, operand2 : in std_logic_vector(15 downto 0); op: in std_logic_vector(2 downto 0); 
 flag_mod: in std_logic_vector(2 downto 0);
 output: out std_logic_vector(15 downto 0); cy, z: out std_logic );
 end ALU;
 
architecture behav of ALU is 
signal temp: std_logic_vector(16 downto 0) := "00000000000000000"; 
signal op_temp : std_logic_vector(15 downto 0);
signal cin, zin: std_logic;
 begin
 alu_proc: process(operand1, operand2, op) is
 begin
 if(op = "000") then
 NULL;

elsif(op = "001") then
  temp <= std_logic_vector(signed(operand1) + signed(operand2)); --signed Addition
  cin <= temp(16);
  if(temp = "00000000000000000") then 
    zin <= '1';
  else 
    zin <= '0';
  end if;

elsif(op = "011") then
  op_temp(15 downto 1) <= operand2(14 downto 0);
  op_temp(0) <= '0';
  temp <= std_logic_vector(signed(operand1) + signed(op_temp));
  cin <= temp(16);
  if(temp = "00000000000000000") then 
    zin <= '1';
  else 
    zin <= '0';
  end if;


elsif(op = "101") then
  temp <= operand1 nand operand2;
  cin <= temp(16);
  if(temp = "00000000000000000") then 
    zin <= '1';
  else 
    zin <= '0';
  end if;


elsif(op = "100") then
   op_temp(15 downto 7) <= operand1(8 downto 0 );
	op_temp(6 downto 0) <= "0000000";
	temp <= std_logic_vector(signed(operand2) + signed(op_temp));
   cin <= temp(16);
   if(temp = "00000000000000000") then 
     zin <= '1';
   else 
     zin <= '0';
   end if;


elsif(op = "010") then
   temp <= std_logic_vector(signed(operand1) +1 );
	cin <= temp(16);
   if(temp = "00000000000000000") then 
     zin <= '1';
   else 
     zin <= '0';
   end if;


else
  NULL;
 
end if;
output <= temp(15 downto 0);
if(flag_mod = "01") then
  z <= zin;
elsif (flag_mod = "11") then
 z<= zin;
 cy <= cin;
 
else NULL;
end if;
end process;
end behav;

   
 