onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /calculator_tb/clk
add wave -noupdate /calculator_tb/rst_n
add wave -noupdate /calculator_tb/row
add wave -noupdate /calculator_tb/col
add wave -noupdate /calculator_tb/sel
add wave -noupdate -radix binary /calculator_tb/seg
add wave -noupdate -radix unsigned /calculator_tb/press_num
add wave -noupdate -radix hexadecimal /calculator_tb/calculator_inst/compute_inst/state
add wave -noupdate -radix unsigned /calculator_tb/calculator_inst/compute_inst/data_in
add wave -noupdate -radix hexadecimal /calculator_tb/calculator_inst/compute_inst/data_out
add wave -noupdate -radix unsigned /calculator_tb/calculator_inst/compute_inst/num1
add wave -noupdate -radix unsigned /calculator_tb/calculator_inst/compute_inst/num2
add wave -noupdate -radix binary /calculator_tb/calculator_inst/compute_inst/flag
add wave -noupdate -radix unsigned /calculator_tb/calculator_inst/compute_inst/operate1
add wave -noupdate -radix unsigned /calculator_tb/calculator_inst/compute_inst/operate2
add wave -noupdate /calculator_tb/calculator_inst/compute_inst/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80565379 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {80554580 ps} {80585420 ps}
