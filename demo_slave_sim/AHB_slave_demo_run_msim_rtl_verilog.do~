transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneiv_hssi_ver
vmap cycloneiv_hssi_ver ./verilog_libs/cycloneiv_hssi_ver
vlog -vlog01compat -work cycloneiv_hssi_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/cycloneiv_hssi_atoms.v}

vlib verilog_libs/cycloneiv_pcie_hip_ver
vmap cycloneiv_pcie_hip_ver ./verilog_libs/cycloneiv_pcie_hip_ver
vlog -vlog01compat -work cycloneiv_pcie_hip_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/cycloneiv_pcie_hip_atoms.v}

vlib verilog_libs/cycloneiv_ver
vmap cycloneiv_ver ./verilog_libs/cycloneiv_ver
vlog -vlog01compat -work cycloneiv_ver {/package/eda/altera/altera14.0/quartus/eda/sim_lib/cycloneiv_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv fifo.v
vlog -sv ahb_frbm.sv
vlog -sv top_level.sv
vlog -sv user_logic.sv
vlog -sv AHB_slave.sv

