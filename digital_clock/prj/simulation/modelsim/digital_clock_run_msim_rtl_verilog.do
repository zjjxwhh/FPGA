transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/digital_clock/src {D:/FPGA/digital_clock/src/digital_clock.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/digital_clock/src {D:/FPGA/digital_clock/src/freq.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/digital_clock/src {D:/FPGA/digital_clock/src/seg7.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/digital_clock/src {D:/FPGA/digital_clock/src/clock_control.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/digital_clock/src {D:/FPGA/digital_clock/src/bin_bcd.v}

vlog -vlog01compat -work work +incdir+D:/FPGA/digital_clock/prj/../sim {D:/FPGA/digital_clock/prj/../sim/digital_clock_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  digital_clock_tb

add wave *
view structure
view signals
run -all
