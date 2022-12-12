----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:51:52 11/26/2020 
-- Design Name: 
-- Module Name:    contador - Behavioral 
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

entity contador is
	Port (CLK : in STD_LOGIC;                     -- Reloj del sistema
			EN : in STD_LOGIC;                      -- Entrada de ENABLE
			Q : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida de 8 bit
end contador;

architecture a_contador of contador is

signal cont : unsigned (7 downto 0):=(others=>'0');
signal modo : STD_LOGIC:='0';

begin
	process (CLK)
		begin
		if CLK'event and CLK='1' then      --Activo en flanco de subida
			-- Inserte aquí el código del contador
			if CLK'event and CLK='1' then   
				if  EN='1' then
					if modo = '1' then
						cont <= cont - 1;    --Cuenta descendente
					else
						cont <= cont + 1;    --Cuenta ascendente
					end if;
				end if;
			end if;
			if (cont = "11111111") then    --Llega a 256
				modo <= '1';                --Cambia de modo
			end if;
			if (cont = "00000000") then    --Llega a 0
				modo <= '0';                --Cambia de modo
			end if;
		end if;
	end process;
Q <= STD_LOGIC_VECTOR(cont);
end a_contador;