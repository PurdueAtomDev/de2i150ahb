
# (C) 2001-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 14.0 200 linux 2015.08.10.14:24:44

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "ahb_master_slave_with_qsys_bfm"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/package/eda/altera/altera14.0/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                        ./libraries/altera_ver/            
  vmap       altera_ver             ./libraries/altera_ver/            
  ensure_lib                        ./libraries/lpm_ver/               
  vmap       lpm_ver                ./libraries/lpm_ver/               
  ensure_lib                        ./libraries/sgate_ver/             
  vmap       sgate_ver              ./libraries/sgate_ver/             
  ensure_lib                        ./libraries/altera_mf_ver/         
  vmap       altera_mf_ver          ./libraries/altera_mf_ver/         
  ensure_lib                        ./libraries/altera_lnsim_ver/      
  vmap       altera_lnsim_ver       ./libraries/altera_lnsim_ver/      
  ensure_lib                        ./libraries/cycloneiv_hssi_ver/    
  vmap       cycloneiv_hssi_ver     ./libraries/cycloneiv_hssi_ver/    
  ensure_lib                        ./libraries/cycloneiv_pcie_hip_ver/
  vmap       cycloneiv_pcie_hip_ver ./libraries/cycloneiv_pcie_hip_ver/
  ensure_lib                        ./libraries/cycloneiv_ver/         
  vmap       cycloneiv_ver          ./libraries/cycloneiv_ver/         
}
ensure_lib                                                 ./libraries/altera_common_sv_packages/                      
vmap       altera_common_sv_packages                       ./libraries/altera_common_sv_packages/                      
ensure_lib                                                 ./libraries/rsp_mux/                                        
vmap       rsp_mux                                         ./libraries/rsp_mux/                                        
ensure_lib                                                 ./libraries/cmd_mux/                                        
vmap       cmd_mux                                         ./libraries/cmd_mux/                                        
ensure_lib                                                 ./libraries/cmd_demux/                                      
vmap       cmd_demux                                       ./libraries/cmd_demux/                                      
ensure_lib                                                 ./libraries/router_001/                                     
vmap       router_001                                      ./libraries/router_001/                                     
ensure_lib                                                 ./libraries/router/                                         
vmap       router                                          ./libraries/router/                                         
ensure_lib                                                 ./libraries/avalon2ahb_bridge_0_avalon_slave_burst_adapter/ 
vmap       avalon2ahb_bridge_0_avalon_slave_burst_adapter  ./libraries/avalon2ahb_bridge_0_avalon_slave_burst_adapter/ 
ensure_lib                                                 ./libraries/avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo/
vmap       avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo ./libraries/avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo/
ensure_lib                                                 ./libraries/avalon2ahb_bridge_0_avalon_slave_agent/         
vmap       avalon2ahb_bridge_0_avalon_slave_agent          ./libraries/avalon2ahb_bridge_0_avalon_slave_agent/         
ensure_lib                                                 ./libraries/mm_master_bfm_0_m0_agent/                       
vmap       mm_master_bfm_0_m0_agent                        ./libraries/mm_master_bfm_0_m0_agent/                       
ensure_lib                                                 ./libraries/avalon2ahb_bridge_0_avalon_slave_translator/    
vmap       avalon2ahb_bridge_0_avalon_slave_translator     ./libraries/avalon2ahb_bridge_0_avalon_slave_translator/    
ensure_lib                                                 ./libraries/mm_master_bfm_0_m0_translator/                  
vmap       mm_master_bfm_0_m0_translator                   ./libraries/mm_master_bfm_0_m0_translator/                  
ensure_lib                                                 ./libraries/rst_controller/                                 
vmap       rst_controller                                  ./libraries/rst_controller/                                 
ensure_lib                                                 ./libraries/mm_interconnect_3/                              
vmap       mm_interconnect_3                               ./libraries/mm_interconnect_3/                              
ensure_lib                                                 ./libraries/mm_interconnect_0/                              
vmap       mm_interconnect_0                               ./libraries/mm_interconnect_0/                              
ensure_lib                                                 ./libraries/ahb2avalon_burst_bridge_0/                      
vmap       ahb2avalon_burst_bridge_0                       ./libraries/ahb2avalon_burst_bridge_0/                      
ensure_lib                                                 ./libraries/avalon2ahb_bridge_0/                            
vmap       avalon2ahb_bridge_0                             ./libraries/avalon2ahb_bridge_0/                            
ensure_lib                                                 ./libraries/ahb_master_slave_2_0/                           
vmap       ahb_master_slave_2_0                            ./libraries/ahb_master_slave_2_0/                           
ensure_lib                                                 ./libraries/mm_slave_bfm_0/                                 
vmap       mm_slave_bfm_0                                  ./libraries/mm_slave_bfm_0/                                 
ensure_lib                                                 ./libraries/mm_master_bfm_0/                                
vmap       mm_master_bfm_0                                 ./libraries/mm_master_bfm_0/                                

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"        -work altera_ver            
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                 -work lpm_ver               
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                    -work sgate_ver             
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                -work altera_mf_ver         
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"            -work altera_lnsim_ver      
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_hssi_atoms.v"     -work cycloneiv_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_pcie_hip_atoms.v" -work cycloneiv_pcie_hip_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_atoms.v"          -work cycloneiv_ver         
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog -sv "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                            -work altera_common_sv_packages                      
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                            -work altera_common_sv_packages                      
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                     -work altera_common_sv_packages                      
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -L altera_common_sv_packages -work rsp_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_rsp_mux.sv"    -L altera_common_sv_packages -work rsp_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -L altera_common_sv_packages -work cmd_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_cmd_mux.sv"    -L altera_common_sv_packages -work cmd_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_cmd_demux.sv"  -L altera_common_sv_packages -work cmd_demux                                      
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_router_001.sv" -L altera_common_sv_packages -work router_001                                     
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_router.sv"     -L altera_common_sv_packages -work router                                         
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -L altera_common_sv_packages -work rsp_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_rsp_mux.sv"    -L altera_common_sv_packages -work rsp_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -L altera_common_sv_packages -work cmd_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_cmd_mux.sv"    -L altera_common_sv_packages -work cmd_mux                                        
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_cmd_demux.sv"  -L altera_common_sv_packages -work cmd_demux                                      
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                            -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                 -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                             -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                             -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                 -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                 -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                              -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                             -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                               -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_router_001.sv" -L altera_common_sv_packages -work router_001                                     
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_router.sv"     -L altera_common_sv_packages -work router                                         
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                     -work avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                   -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                            -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                  -L altera_common_sv_packages -work mm_master_bfm_0_m0_agent                       
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                              -L altera_common_sv_packages -work avalon2ahb_bridge_0_avalon_slave_translator    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                             -L altera_common_sv_packages -work mm_master_bfm_0_m0_translator                  
  vlog     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                   -work rst_controller                                 
  vlog     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                 -work rst_controller                                 
  vlog     "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3.v"                                          -work mm_interconnect_3                              
  vlog     "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0.v"                                          -work mm_interconnect_0                              
  vlog -sv "$QSYS_SIMDIR/submodules/ahb_avalon_bridge_with_burst.sv"                                -L altera_common_sv_packages -work ahb2avalon_burst_bridge_0                      
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_ahb_bridge.sv"                                           -L altera_common_sv_packages -work avalon2ahb_bridge_0                            
  vlog -sv "$QSYS_SIMDIR/submodules/top_level.sv"                                                   -L altera_common_sv_packages -work ahb_master_slave_2_0                           
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                  -L altera_common_sv_packages -work mm_slave_bfm_0                                 
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_master_bfm.sv"                                 -L altera_common_sv_packages -work mm_master_bfm_0                                
  vlog     "$QSYS_SIMDIR/ahb_master_slave_with_qsys_bfm.v"                                                                                                                            
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L rsp_mux -L cmd_mux -L cmd_demux -L router_001 -L router -L avalon2ahb_bridge_0_avalon_slave_burst_adapter -L avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo -L avalon2ahb_bridge_0_avalon_slave_agent -L mm_master_bfm_0_m0_agent -L avalon2ahb_bridge_0_avalon_slave_translator -L mm_master_bfm_0_m0_translator -L rst_controller -L mm_interconnect_3 -L mm_interconnect_0 -L ahb2avalon_burst_bridge_0 -L avalon2ahb_bridge_0 -L ahb_master_slave_2_0 -L mm_slave_bfm_0 -L mm_master_bfm_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L rsp_mux -L cmd_mux -L cmd_demux -L router_001 -L router -L avalon2ahb_bridge_0_avalon_slave_burst_adapter -L avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo -L avalon2ahb_bridge_0_avalon_slave_agent -L mm_master_bfm_0_m0_agent -L avalon2ahb_bridge_0_avalon_slave_translator -L mm_master_bfm_0_m0_translator -L rst_controller -L mm_interconnect_3 -L mm_interconnect_0 -L ahb2avalon_burst_bridge_0 -L avalon2ahb_bridge_0 -L ahb_master_slave_2_0 -L mm_slave_bfm_0 -L mm_master_bfm_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
