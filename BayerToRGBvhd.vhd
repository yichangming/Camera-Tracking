-- BayerToRGB

-- Goal: convert a stream of Bayer formated data to 5 bit RGB data

-- Change Log:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BayerToRGB is port(
					oDATA: out STD_lOGIC_VECTOR(14 downto 0);  -- 5 bit RGB
					oDVAL: out STD_LOGIC;
					oX_Cont: out STD_LOGIC_VECTOR(15 downto 0);
					oY_Cont: out STD_LOGIC_VECTOR(15 downto 0);
					iX_Cont: in STD_LOGIC_VECTOR(15 downto 0);
					iY_Cont: in STD_LOGIC_VECTOR(15 downto 0);
					iDATA: in STD_lOGIC_VECTOR(11 downto 0)
					);
end ;
	
architecture behavior of BayerToRGB is 

signal LastRed: STD_LOGIC_VECTOR(11 downto 0);

signal outofcontrol: STD_LOGIC;
begin
	oX_Cont <= iX_Cont(15 downto 1) & '0';
	oY_Cont <= iY_Cont;
	
	process(iX_Cont,iY_Cont)
	begin
		if(iY_Cont(0) = '0')  then -- its an even bit;
											-- this line should have Red and Green -> RGRGRG
			if(iX_Cont(0) = '0') then -- its a red value
				LastRed <= iDATA;
			else  -- its a green value
				oDATA <= LastRed(11 downto 7) & iDATA(11 downto 7) & "00000";
			end if;
		else  -- is an odd line --> Data is Green Blue GBGBGB
		
		end if;
	end process;	
end behavior;