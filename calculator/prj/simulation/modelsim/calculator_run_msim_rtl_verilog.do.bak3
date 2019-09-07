transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/calculator/src {D:/FPGA/calculator/src/key_scan.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/calculator/src {D:/FPGA/calculator/src/seg7.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/calculator/src {D:/FPGA/calculator/src/freq.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/calculator/src {D:/FPGA/calculator/src/calculator.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/calculator/src {D:/FPGA/calculator/src/compute.v}

vlog -vlog01compat -work work +incdir+D:/FPGA/calculator/prj/../sim {D:/FPGA/calculator/prj/../sim/calculator_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  calculator_tb

add wave *
view structure
view signals
run -all
