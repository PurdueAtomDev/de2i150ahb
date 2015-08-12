# setup variables for simulation script
set system_name      ahb_master_slave_with_qsys_bfm
set QSYS_SIMDIR      $system_name/simulation
set TOP_LEVEL_NAME   tb
source $QSYS_SIMDIR/mentor/msim_setup.tcl

# compile system
dev_com
com

# compile testbench and test program
vlog -sv fifo_w.v
vlog -sv fifo_r.v
vlog -sv user_logic.sv
vlog -sv AHB_write_master.sv
vlog -sv AHB_slave.sv
vlog -sv AHB_read_master.sv
vlog -sv latency_aware_read_master.sv
vlog -sv burst_read_master.sv
vlog -sv AHB_master_bfm.sv
vlog -sv test_program.sv -L altera_common_sv_packages
vlog -sv tb.sv

# load and run simulation
elab_debug
##do wave.do


# alias to re-compile changes made to test program, load and run simulation
alias rerun {
   vlog -sv test_program.sv -L altera_common_sv_packages
   elab_debug
   do wave.do
   run 50ns
}

