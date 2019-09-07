onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group 1 /top_tb/clk
add wave -noupdate -expand -group 1 /top_tb/rst_n
add wave -noupdate -expand -group 1 /top_tb/row
add wave -noupdate -expand -group 1 /top_tb/col
add wave -noupdate -expand -group 1 /top_tb/sel
add wave -noupdate -expand -group 1 /top_tb/seg
add wave -noupdate -expand -group 1 /top_tb/beep
add wave -noupdate -expand -group 1 -radix hexadecimal /top_tb/press_num
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/clk
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/rst_n
add wave -noupdate -expand -group 计算 -radix unsigned /top_tb/top_inst/compute_dut/flag
add wave -noupdate -expand -group 计算 -radix hexadecimal /top_tb/top_inst/compute_dut/press_num
add wave -noupdate -expand -group 计算 -radix hexadecimal /top_tb/top_inst/compute_dut/data
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/beep
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/cnt
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/clk_1khz
add wave -noupdate -expand -group 计算 -radix unsigned /top_tb/top_inst/compute_dut/state_s
add wave -noupdate -expand -group 计算 -radix decimal /top_tb/top_inst/compute_dut/num1
add wave -noupdate -expand -group 计算 -radix decimal /top_tb/top_inst/compute_dut/num2
add wave -noupdate -expand -group 计算 -radix unsigned /top_tb/top_inst/compute_dut/data_in
add wave -noupdate -expand -group 计算 -radix unsigned /top_tb/top_inst/compute_dut/data_t
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/flag_s
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/flag_t
add wave -noupdate -expand -group 计算 /top_tb/top_inst/compute_dut/flag_o
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/clk
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/rst_n
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/row
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/col
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/flag
add wave -noupdate -expand -group key_scan -radix hexadecimal /top_tb/top_inst/key_scan_dut/press_num
add wave -noupdate -expand -group key_scan -radix unsigned /top_tb/top_inst/key_scan_dut/cnt
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/clk_1khz
add wave -noupdate -expand -group key_scan -radix unsigned /top_tb/top_inst/key_scan_dut/state
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/cnt_time
add wave -noupdate -expand -group key_scan /top_tb/top_inst/key_scan_dut/row_col
add wave -noupdate -expand -group seg_driver /top_tb/top_inst/seg_driver_dut/clk
add wave -noupdate -expand -group seg_driver /top_tb/top_inst/seg_driver_dut/rst_n
add wave -noupdate -expand -group seg_driver /top_tb/top_inst/seg_driver_dut/data_in
add wave -noupdate -expand -group seg_driver /top_tb/top_inst/seg_driver_dut/sel
add wave -noupdate -expand -group seg_driver /top_tb/top_inst/seg_driver_dut/seg
add wave -noupdate -expand -group seg_driver /top_tb/top_inst/seg_driver_dut/clk_1khz
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 111
configure wave -valuecolwidth 45
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {317185969 ps}
