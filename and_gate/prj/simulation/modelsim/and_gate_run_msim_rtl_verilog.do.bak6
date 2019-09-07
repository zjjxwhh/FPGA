transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/and_gate/src {D:/FPGA/and_gate/src/and_gate.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/and_gate/src {D:/FPGA/and_gate/src/top1.v}

vlog -vlog01compat -work work +incdir+D:/FPGA/and_gate/prj/../sim {D:/FPGA/and_gate/prj/../sim/top1_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top1_tb

add wave *
view structure
view signals
run -all
