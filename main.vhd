----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:48 12/21/2020 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
	Port ( CLK : in STD_LOGIC; -- Reloj del sistema
		  	 INC : in STD_LOGIC; -- Incremento de frecuencia
			 DEC : in STD_LOGIC; -- Decremento de frecuencia
			 SALIDA : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida 8 bit
end main;

architecture a_main of main is

component contador is
	Port (CLK : in STD_LOGIC;                     -- Reloj del sistema
		   EN : in STD_LOGIC;                      -- Entrada de ENABLE
		   Q : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida de 8 bit
end component;

component gen_enable is
	Port ( CLK : in STD_LOGIC;                             -- reloj del sistema
			 VALOR : in STD_LOGIC_VECTOR (31 downto 0);      -- No. de ciclos del periodo
			 EN : out STD_LOGIC);                            -- señal de salida de ENABLE
end component;

component aut_control is
	Port ( CLK : in STD_LOGIC;                              -- Reloj del sistema
		 	 INC : in STD_LOGIC;                              -- Señal de incremento de frecuencia
		 	 DEC : in STD_LOGIC;                              -- Señal de decremento de frecuencia
		  	 VALOR : out STD_LOGIC_VECTOR (31 downto 0));     -- valor
end component;

 signal VALOR1 : STD_LOGIC_VECTOR (31 downto 0);
 signal EN1 : STD_LOGIC;
 
begin

	U1 : contador port map (CLK => CLK, EN => EN1, Q => SALIDA);
   U2 : gen_enable port map (CLK => CLK, VALOR => VALOR1, EN => EN1);
	U3 : aut_control port map (CLK => CLK, INC => INC, DEC => DEC, VALOR => VALOR1);
	
end a_main;

