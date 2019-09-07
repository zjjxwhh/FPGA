onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group digital_clock /digital_clock_tb/clk
add wave -noupdate -group digital_clock /digital_clock_tb/rst_n
add wave -noupdate -group digital_clock /digital_clock_tb/sel
add wave -noupdate -group digital_clock /digital_clock_tb/seg
add wave -noupdate -group freq /digital_clock_tb/digital_clock_inst/freq_dut/clk
add wave -noupdate -group freq /digital_clock_tb/digital_clock_inst/freq_dut/rst_n
add wave -noupdate -group freq /digital_clock_tb/digital_clock_inst/freq_dut/clk_1khz
add wave -noupdate -group freq /digital_clock_tb/digital_clock_inst/freq_dut/cnt
add wave -noupdate -expand -group clock_control /digital_clock_tb/digital_clock_inst/clock_control_dut/clk
add wave -noupdate -expand -group clock_control /digital_clock_tb/digital_clock_inst/clock_control_dut/rst_n
add wave -noupdate -expand -group clock_control -radix hexadecimal /digital_clock_tb/digital_clock_inst/clock_control_dut/data_out
add wave -noupdate -expand -group clock_control -radix unsigned /digital_clock_tb/digital_clock_inst/clock_control_dut/cnt
add wave -noupdate -expand -group clock_control /digital_clock_tb/digital_clock_inst/clock_control_dut/clk_1hz
add wave -noupdate -expand -group bcd_sec -radix unsigned /digital_clock_tb/digital_clock_inst/bin_bcd_sec/bin
add wave -noupdate -expand -group bcd_sec -radix hexadecimal /digital_clock_tb/digital_clock_inst/bin_bcd_sec/bcd
add wave -noupdate -expand -group bed_min -radix unsigned /digital_clock_tb/digital_clock_inst/bin_bcd_min/bin
add wave -noupdate -expand -group bed_min -radix hexadecimal /digital_clock_tb/digital_clock_inst/bin_bcd_min/bcd
add wave -noupdate -expand -group bcd_hour -radix unsigned /digital_clock_tb/digital_clock_inst/bin_bcd_hour/bin
add wave -noupdate -expand -group bcd_hour -radix hexadecimal /digital_clock_tb/digital_clock_inst/bin_bcd_hour/bcd
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/clk_1khz
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/rst_n
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/data_in
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/sel
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/seg
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/state
add wave -noupdate -expand -group seg7 /digital_clock_tb/digital_clock_inst/seg7_dut/temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {22499098624 ps}
