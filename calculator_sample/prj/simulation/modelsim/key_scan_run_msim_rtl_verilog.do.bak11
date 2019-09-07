transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/src {C:/Users/15929/Desktop/calculator/src/beep_driver.v}
vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/src {C:/Users/15929/Desktop/calculator/src/compute.v}
vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/src {C:/Users/15929/Desktop/calculator/src/seg7.v}
vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/src {C:/Users/15929/Desktop/calculator/src/freq.v}
vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/src {C:/Users/15929/Desktop/calculator/src/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/src {C:/Users/15929/Desktop/calculator/src/key_scan.v}

vlog -vlog01compat -work work +incdir+C:/Users/15929/Desktop/calculator/prj/../sim {C:/Users/15929/Desktop/calculator/prj/../sim/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
