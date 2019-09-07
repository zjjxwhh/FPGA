transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/seg_driver/src {D:/FPGA/seg_driver/src/freq.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/seg_driver/src {D:/FPGA/seg_driver/src/seg_driver.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/seg_driver/src {D:/FPGA/seg_driver/src/seg7.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/seg_driver/src {D:/FPGA/seg_driver/src/shift_data.v}

vlog -vlog01compat -work work +incdir+D:/FPGA/seg_driver/prj/../sim {D:/FPGA/seg_driver/prj/../sim/seg_driver_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  seg_driver_tb

add wave *
view structure
view signals
run -all
