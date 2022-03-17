set_property PACKAGE_PIN AC19 [get_ports clk]
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

#reset
set_property PACKAGE_PIN Y3 [get_ports resetn]


#LED
set_property PACKAGE_PIN K23 [get_ports {led[0]}]
set_property PACKAGE_PIN J21 [get_ports {led[1]}]
set_property PACKAGE_PIN H23 [get_ports {led[2]}]
set_property PACKAGE_PIN J19 [get_ports {led[3]}]
set_property PACKAGE_PIN G9 [get_ports {led[4]}]
set_property PACKAGE_PIN J26 [get_ports {led[5]}]
set_property PACKAGE_PIN J23 [get_ports {led[6]}]
set_property PACKAGE_PIN J8 [get_ports {led[7]}]
set_property PACKAGE_PIN H8 [get_ports {led[8]}]
set_property PACKAGE_PIN G8 [get_ports {led[9]}]
set_property PACKAGE_PIN F7 [get_ports {led[10]}]
set_property PACKAGE_PIN A4 [get_ports {led[11]}]
set_property PACKAGE_PIN A5 [get_ports {led[12]}]
set_property PACKAGE_PIN A3 [get_ports {led[13]}]
set_property PACKAGE_PIN D5 [get_ports {led[14]}]
set_property PACKAGE_PIN H7 [get_ports {led[15]}]

#led_rg 0/1
set_property PACKAGE_PIN G7 [get_ports {led_rg0[0]}]
set_property PACKAGE_PIN F8 [get_ports {led_rg0[1]}]
set_property PACKAGE_PIN B5 [get_ports {led_rg1[0]}]
set_property PACKAGE_PIN D6 [get_ports {led_rg1[1]}]

#NUM
set_property PACKAGE_PIN D3 [get_ports {num_csn[7]}]
set_property PACKAGE_PIN D25 [get_ports {num_csn[6]}]
set_property PACKAGE_PIN D26 [get_ports {num_csn[5]}]
set_property PACKAGE_PIN E25 [get_ports {num_csn[4]}]
set_property PACKAGE_PIN E26 [get_ports {num_csn[3]}]
set_property PACKAGE_PIN G25 [get_ports {num_csn[2]}]
set_property PACKAGE_PIN G26 [get_ports {num_csn[1]}]
set_property PACKAGE_PIN H26 [get_ports {num_csn[0]}]

set_property PACKAGE_PIN C3 [get_ports {num_a_g[0]}]
set_property PACKAGE_PIN E6 [get_ports {num_a_g[1]}]
set_property PACKAGE_PIN B2 [get_ports {num_a_g[2]}]
set_property PACKAGE_PIN B4 [get_ports {num_a_g[3]}]
set_property PACKAGE_PIN E5 [get_ports {num_a_g[4]}]
set_property PACKAGE_PIN D4 [get_ports {num_a_g[5]}]
set_property PACKAGE_PIN A2 [get_ports {num_a_g[6]}]
#set_property PACKAGE_PIN C4 :DP

#switch
set_property PACKAGE_PIN AC21 [get_ports {switch[7]}]
set_property PACKAGE_PIN AD24 [get_ports {switch[6]}]
set_property PACKAGE_PIN AC22 [get_ports {switch[5]}]
set_property PACKAGE_PIN AC23 [get_ports {switch[4]}]
set_property PACKAGE_PIN AB6 [get_ports {switch[3]}]
set_property PACKAGE_PIN W6 [get_ports {switch[2]}]
set_property PACKAGE_PIN AA7 [get_ports {switch[1]}]
set_property PACKAGE_PIN Y6 [get_ports {switch[0]}]

#btn_key
set_property PACKAGE_PIN V8 [get_ports {btn_key_col[0]}]
set_property PACKAGE_PIN V9 [get_ports {btn_key_col[1]}]
set_property PACKAGE_PIN Y8 [get_ports {btn_key_col[2]}]
set_property PACKAGE_PIN V7 [get_ports {btn_key_col[3]}]
set_property PACKAGE_PIN U7 [get_ports {btn_key_row[0]}]
set_property PACKAGE_PIN W8 [get_ports {btn_key_row[1]}]
set_property PACKAGE_PIN Y7 [get_ports {btn_key_row[2]}]
set_property PACKAGE_PIN AA8 [get_ports {btn_key_row[3]}]

#btn_step
set_property PACKAGE_PIN Y5 [get_ports {btn_step[0]}]
set_property PACKAGE_PIN V6 [get_ports {btn_step[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports resetn]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rg0[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rg1[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {num_a_g[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {num_csn[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_key_col[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_key_row[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_step[*]}]


set_false_path -from [get_clocks -of_objects [get_pins pll.clk_pll/inst/plle2_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins pll.clk_pll/inst/plle2_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins pll.clk_pll/inst/plle2_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins pll.clk_pll/inst/plle2_adv_inst/CLKOUT1]]

###my new###
#uart
set_property PACKAGE_PIN H19 [get_ports txd]
set_property IOSTANDARD LVCMOS33 [get_ports txd]

#ring oscillator
#notice
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets {sensor0/test0/ring_osc/chain[0]}]
#set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets {ring_osc/chain[12]}]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets {sensor0/test0/ring_osc/chain[2]}]



create_pblock pblock_alu_slices32
add_cells_to_pblock [get_pblocks pblock_alu_slices32] [get_cells -quiet [list u_cpu/mycpu/pipeline/exe/alu]]
resize_pblock [get_pblocks pblock_alu_slices32] -add {SLICE_X30Y92:SLICE_X33Y99}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_alu_slices32]
set_property IS_SOFT FALSE [get_pblocks pblock_alu_slices32]

create_pblock pblock_ring_osc
resize_pblock [get_pblocks pblock_ring_osc] -add {SLICE_X30Y91:SLICE_X31Y91}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_ring_osc]
set_property IS_SOFT FALSE [get_pblocks pblock_ring_osc]
#notice
#add_cells_to_pblock [get_pblocks pblock_ring_osc] [get_cells -quiet [list sensor0/test0/ring_osc]]




create_pblock pblock_ro_sm
#notice
#add_cells_to_pblock [get_pblocks pblock_ro_sm] [get_cells -quiet [list sensor0/test0/ring_osc]]
resize_pblock [get_pblocks pblock_ro_sm] -add {SLICE_X48Y73:SLICE_X49Y73}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_ro_sm]
set_property IS_SOFT FALSE [get_pblocks pblock_ro_sm]




create_pblock pblock_multiplexer
add_cells_to_pblock [get_pblocks pblock_multiplexer] [get_cells -quiet [list u_cpu/mycpu/pipeline/exe/multiplexer]]
resize_pblock [get_pblocks pblock_multiplexer] -add {SLICE_X34Y74:SLICE_X65Y99}
resize_pblock [get_pblocks pblock_multiplexer] -add {DSP48_X2Y30:DSP48_X2Y39}
resize_pblock [get_pblocks pblock_multiplexer] -add {RAMB18_X2Y30:RAMB18_X3Y39}
resize_pblock [get_pblocks pblock_multiplexer] -add {RAMB36_X2Y15:RAMB36_X3Y19}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_multiplexer]
set_property IS_SOFT FALSE [get_pblocks pblock_multiplexer]



create_pblock pblock_divider
resize_pblock [get_pblocks pblock_divider] -add {SLICE_X34Y38:SLICE_X65Y71}
resize_pblock [get_pblocks pblock_divider] -add {DSP48_X2Y16:DSP48_X2Y27}
resize_pblock [get_pblocks pblock_divider] -add {RAMB18_X2Y16:RAMB18_X3Y27}
resize_pblock [get_pblocks pblock_divider] -add {RAMB36_X2Y8:RAMB36_X3Y13}
add_cells_to_pblock [get_pblocks pblock_divider] [get_cells -quiet [list u_cpu/mycpu/pipeline/exe/divider]]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_divider]
set_property IS_SOFT FALSE [get_pblocks pblock_divider]


create_pblock pblock_rd
resize_pblock [get_pblocks pblock_rd] -add {SLICE_X48Y37:SLICE_X49Y37}
add_cells_to_pblock [get_pblocks pblock_rd] [get_cells -quiet [list sensor0/test0/ring_osc]]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_rd]
set_property IS_SOFT FALSE [get_pblocks pblock_rd]