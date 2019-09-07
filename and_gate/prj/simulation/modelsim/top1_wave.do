onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group top -radix binary /top1_tb/a
add wave -noupdate -expand -group top -radix binary /top1_tb/b
add wave -noupdate -expand -group top -radix binary /top1_tb/c
add wave -noupdate -expand -group top -radix binary /top1_tb/d
add wave -noupdate -expand -group and_gate1 -radix binary /top1_tb/top1_inst/and_gate_dut1/a
add wave -noupdate -expand -group and_gate1 -radix binary /top1_tb/top1_inst/and_gate_dut1/b
add wave -noupdate -expand -group and_gate1 -radix binary /top1_tb/top1_inst/and_gate_dut1/s
add wave -noupdate -expand -group and_gate2 -radix binary /top1_tb/top1_inst/and_gate_dut2/a
add wave -noupdate -expand -group and_gate2 -radix binary /top1_tb/top1_inst/and_gate_dut2/b
add wave -noupdate -expand -group and_gate2 -radix binary /top1_tb/top1_inst/and_gate_dut2/s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {401268 ps} 0}
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
WaveRestoreZoom {0 ps} {840 ns}
