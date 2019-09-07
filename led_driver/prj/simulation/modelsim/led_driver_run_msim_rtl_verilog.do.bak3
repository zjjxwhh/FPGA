transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/led_driver/src {D:/FPGA/led_driver/src/led_driver.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/led_driver/src {D:/FPGA/led_driver/src/freq.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/led_driver/src {D:/FPGA/led_driver/src/led_run.v}

vlog -vlog01compat -work work +incdir+D:/FPGA/led_driver/prj/../sim {D:/FPGA/led_driver/prj/../sim/led_driver_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  led_driver_tb

add wave *
view structure
view signals
run -all
