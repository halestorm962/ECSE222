-----------------------------------
-- Author: Shabbir Hussain, additions by Alex Hale and Grier Ostermann
-- Email: shabbir.hussain@mail.mcgill.ca / alexander.hale@mail.mcgill.ca, grier.ostermann@mail.mcgill.ca

-- This module sends pixel data to the vga output
----------------------------------- 
-- Import the necessary libraries
library ieee;
use ieee.std_logic_1164.all;


-- Declare 	
	entity video_blank is
    Port (
    --Inputs
    clk         : in std_logic; -- 108 MHz clock
    rst         : in std_logic;

    color       : in std_logic_vector(2 downto 0);
    blank       : in std_logic;

    -- Outputs
    vga_r       : out std_logic_vector(7 downto 0);
    vga_g       : out std_logic_vector(7 downto 0);
    vga_b       : out std_logic_vector(7 downto 0)

    );

end video_blank;

architecture behaviour of video_blank is
	 component color_decoder is
    Port (
            color    : in std_logic_vector(2 downto 0); 
            r       : out std_logic_vector(7 downto 0);
				g       : out std_logic_vector(7 downto 0);
				b       : out std_logic_vector(7 downto 0)
        );
	 end component;
	 
	 signal r_reg       :  std_logic_vector(7 downto 0);
    signal g_reg       :  std_logic_vector(7 downto 0);
    signal b_reg       :  std_logic_vector(7 downto 0);
begin

    color_dec : color_decoder
	 port map (
	   color => color,
		r => r_reg,
		g => g_reg,
		b => b_reg
	 );
	
    process(clk,rst)
    begin
        if rst = '1' then
                vga_r <= (others => '0');
                vga_g <= (others => '0');
                vga_b <= (others => '0');
        elsif rising_edge(clk) then
				
				if (blank = '0') then      -- set all outputs to zero
					vga_r <= (others => '0');
					vga_g <= (others => '0');
					vga_b <= (others => '0');
				else
					vga_r <= r_reg;       -- set all outputs to colour registers
					vga_g <= g_reg;
					vga_b <= b_reg;
				end if;
				
				-- ADD YOUR CODE ABOVE
		  
        end if;

    end process;

end behaviour;
