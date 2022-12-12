----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:56:33 12/11/2020 
-- Design Name: 
-- Module Name:    aut_control - Behavioral 
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

entity aut_control is
	Port ( CLK : in STD_LOGIC;                              -- Reloj del sistema
		 	 INC : in STD_LOGIC;                              -- Señal de incremento de frecuencia
		 	 DEC : in STD_LOGIC;                              -- Señal de decremento de frecuencia
		  	 VALOR : out STD_LOGIC_VECTOR (31 downto 0));     -- valor
end aut_control;

architecture a_aut_control of aut_control is

	constant VAL_MIN : unsigned (31 downto 0) := "00000000000000000000000000010100"; --VALORMIN = 20 en decimal redondeandolo, calculado en la sesion 6
	constant VAL_MAX : unsigned (31 downto 0) := "00000000000000000000000001100010"; --VALORMAX = 98 calculado en la sesion 6
	type STATE_TYPE is (V_MIN,V_INC,V_DEC,V_MAX,ESPERA);
	signal ST : STATE_TYPE := V_MAX;                      -- Frecuencia inicial más baja
	signal s_val : unsigned (31 downto 0):=(others=>'0');
	
begin
	process (CLK)
	begin
		if CLK'event and CLK='1' then
			case ST is
				when V_MIN =>         --Cuando el estado es V_MIN
				-- Describa el código de los estados
				-- En V_INC y V_DEC es muy importante comprobar
				-- primero la llegada al límite de s_val antes
				-- de comprobar si la señal INC o DEC está activa.
						s_val<=VAL_MIN;          --Se asigna a s_val el valor minimo
						if DEC = '1' then        --Se activa DEC
							ST<=V_INC;            --Al activarse DEC el estado pasa a V_INC
						else
							ST<=V_MIN;            --Si no se activa DEC el estado es otra vez V_MIN
						end if;
				
				when V_INC =>                        --Cuando el estado es V_INC
						s_val<=s_val + 1;              --Se incrementa s_val una unidad cada ciclo de reloj
						if s_val>=VAL_MAX - 1 then     --Cuando se llega al valor máximo se pasa a V_MAX
							ST <= V_MAX;
						elsif DEC = '1'  then          --Se activa DEC
							ST <= V_INC;                --Al activarse DEC el estado pasa a V_INC
						else                           --Si se desactiva DEC el estado pasa a ESPERA
							ST <= ESPERA;
						end if;
					
				when V_MAX =>                 --Cuando el estado es V_MAX
						s_val<=VAL_MAX;         --Se asigna a s_val el valor máximo
						if INC = '1' then       --Se activa INC
							ST <= V_DEC;         --Al activarse INC el estado pasa a V_DEC
						else                    --Si no se activa INC el estado es otra vez V_MAX
							ST <= V_MAX;
						end if;
						
				when V_DEC =>                      --Cuando el estado es V_DEC
						s_val<=s_val-1;              --Se decrementa s_val una unidad cada ciclo de reloj
						if s_val<=VAL_MIN+1 then     --Cuando se llega al valor mínimo se pasa a V_MIN.
							ST <= V_MIN;
						elsif INC = '1' then         --Se activa INC
							ST <= V_DEC;              --Al activarse INC el estado pasa a V_DEC
						else                         --Si no se activa INC el estado pasa a ESPERA
							ST <= ESPERA;
						end if;
				
				when ESPERA =>                   --Cuando el estado pasa a ESPERA
						if INC = '1' then          --Se activa INC
							ST <= V_DEC;            --Al activarse INC el estado pasa a V_DEC
						elsif DEC = '1' then       --Se activa DEC
							ST <= V_INC;            --Al activarse DEC el estado pasa a V_INC
						end if;
				
			end case;
		end if;
	end process;
	
VALOR<= STD_LOGIC_VECTOR(s_val) ; -- Complete la descripción
                                  --El valor es s_val
end a_aut_control;
