----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:10 12/03/2020 
-- Design Name: 
-- Module Name:    gen_enable - Behavioral 
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

entity gen_enable is
	Port ( CLK : in STD_LOGIC;                             -- reloj del sistema
			 VALOR : in STD_LOGIC_VECTOR (31 downto 0);      -- No. de ciclos del periodo
			 EN : out STD_LOGIC);                            -- señal de salida de ENABLE
end gen_enable;

architecture a_gen_enable of gen_enable is
	type STATE_TYPE is (EN_OFF,EN_ON);
	signal ST : STATE_TYPE := EN_OFF;
	signal cont : unsigned (31 downto 0):=(others=>'0');
begin

		process (CLK)
			begin
				if CLK'event and CLK='1' then                  --Activo en flanco de subida
					case ST is
						when EN_OFF =>                           --Caso cuando ENABLE esta en OFF
						-- Complete el código de cada estado
							cont <= cont + 1;                     --Suma el contador por periodo del reloj
							if cont >= unsigned(VALOR) - 2 then   --Cuando cont >= VALOR - 2
								ST <= EN_ON;                       --El estado pasa a ON si ocurre lo del if
							end if;
						when EN_ON =>                                  --Caso cuando ENABLE esta en ON
							cont <= "00000000000000000000000000000000"; --El contador es 0
							ST <= EN_OFF;                               --ENABLE pasa siempre a OFF despues de un ciclo
					end case;
				end if;
		end process;
		
	EN<='1' when ST = EN_ON else '0' ; --Complete la linea 
	
end a_gen_enable;

