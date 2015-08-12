
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
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="ahb_master_slave_with_qsys_bfm"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="/package/eda/altera/altera14.0/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera_common_sv_packages/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/router/
mkdir -p ./libraries/avalon2ahb_bridge_0_avalon_slave_burst_adapter/
mkdir -p ./libraries/avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo/
mkdir -p ./libraries/avalon2ahb_bridge_0_avalon_slave_agent/
mkdir -p ./libraries/mm_master_bfm_0_m0_agent/
mkdir -p ./libraries/avalon2ahb_bridge_0_avalon_slave_translator/
mkdir -p ./libraries/mm_master_bfm_0_m0_translator/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/mm_interconnect_3/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/ahb2avalon_burst_bridge_0/
mkdir -p ./libraries/avalon2ahb_bridge_0/
mkdir -p ./libraries/ahb_master_slave_2_0/
mkdir -p ./libraries/mm_slave_bfm_0/
mkdir -p ./libraries/mm_master_bfm_0/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cycloneiv_hssi_ver/
mkdir -p ./libraries/cycloneiv_pcie_hip_ver/
mkdir -p ./libraries/cycloneiv_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"        -work altera_ver            
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                 -work lpm_ver               
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                    -work sgate_ver             
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                -work altera_mf_ver         
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"            -work altera_lnsim_ver      
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_hssi_atoms.v"     -work cycloneiv_hssi_ver    
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_pcie_hip_atoms.v" -work cycloneiv_pcie_hip_ver
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneiv_atoms.v"          -work cycloneiv_ver         
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                               -work altera_common_sv_packages                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                               -work altera_common_sv_packages                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                        -work altera_common_sv_packages                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -work rsp_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_rsp_mux.sv"    -work rsp_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -work cmd_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_cmd_mux.sv"    -work cmd_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_cmd_demux.sv"  -work cmd_demux                                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_router_001.sv" -work router_001                                     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3_router.sv"     -work router                                         
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -work rsp_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_rsp_mux.sv"    -work rsp_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                    -work cmd_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_cmd_mux.sv"    -work cmd_mux                                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_cmd_demux.sv"  -work cmd_demux                                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                            -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                 -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                             -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                             -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                 -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                 -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                              -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                             -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                               -work avalon2ahb_bridge_0_avalon_slave_burst_adapter 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_router_001.sv" -work router_001                                     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0_router.sv"     -work router                                         
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                        -work avalon2ahb_bridge_0_avalon_slave_agent_rsp_fifo
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                   -work avalon2ahb_bridge_0_avalon_slave_agent         
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                            -work avalon2ahb_bridge_0_avalon_slave_agent         
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                  -work mm_master_bfm_0_m0_agent                       
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                              -work avalon2ahb_bridge_0_avalon_slave_translator    
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                             -work mm_master_bfm_0_m0_translator                  
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                      -work rst_controller                                 
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                    -work rst_controller                                 
  vlogan +v2k           "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_3.v"             -work mm_interconnect_3                              
  vlogan +v2k           "$QSYS_SIMDIR/submodules/ahb_master_slave_with_qsys_bfm_mm_interconnect_0.v"             -work mm_interconnect_0                              
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/ahb_avalon_bridge_with_burst.sv"                                -work ahb2avalon_burst_bridge_0                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/avalon_ahb_bridge.sv"                                           -work avalon2ahb_bridge_0                            
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/top_level.sv"                                                   -work ahb_master_slave_2_0                           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                  -work mm_slave_bfm_0                                 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_mm_master_bfm.sv"                                 -work mm_master_bfm_0                                
  vlogan +v2k           "$QSYS_SIMDIR/ahb_master_slave_with_qsys_bfm.v"                                                                                               
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
