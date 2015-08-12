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

vlog -vlog01compat -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/fifo_w.v}
vlog -vlog01compat -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/fifo_r.v}
vlib ahb_master_slave_with_qsys_bfm
vmap ahb_master_slave_with_qsys_bfm ahb_master_slave_with_qsys_bfm
vlog -vlog01compat -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/ahb_master_slave_with_qsys_bfm.v}
vlog -vlog01compat -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3.v}
vlog -vlog01compat -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0.v}
vlog -sv -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/burst_read_master.sv}
vlog -sv -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/AHB_master_bfm.sv}
vlog -sv -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/user_logic.sv}
vlog -sv -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/AHB_write_master.sv}
vlog -sv -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/AHB_slave.sv}
vlog -sv -work work +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/AHB_read_master.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_rsp_mux.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_cmd_mux.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_cmd_demux.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_burst_adapter_13_1.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_address_alignment.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_router_001.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_router.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_router_001.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_router.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/ahb_avalon_bridge_with_burst.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/avalon_ahb_bridge.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/top_level.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_avalon_mm_slave_bfm.sv}
vlog -sv -work ahb_master_slave_with_qsys_bfm +incdir+/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules {/home/ecegridfs/a/mg196/Desktop/de2i150_AHB/demo_master_sim/ahb_master_slave_with_qsys_bfm/synthesis/submodules/altera_avalon_mm_master_bfm.sv}

