# TCL File Generated by Component Editor 14.0
# Mon Aug 10 15:05:49 EDT 2015
# DO NOT MODIFY


# 
# ahb2avalon_burst_bridge "ahb to avalon bridge with burst" v1.0
#  2015.08.10.15:05:49
# 
# 

# 
# request TCL package from ACDS 14.0
# 
package require -exact qsys 14.0


# 
# module ahb2avalon_burst_bridge
# 
set_module_property DESCRIPTION ""
set_module_property NAME ahb2avalon_burst_bridge
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "ahb to avalon bridge with burst"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL ahb_avalon_bridge_with_burst
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file ahb_avalon_bridge_with_burst.sv SYSTEM_VERILOG PATH ahb_avalon_bridge_with_burst.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL ahb_avalon_bridge_with_burst
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file ahb_avalon_bridge_with_burst.sv SYSTEM_VERILOG PATH ahb_avalon_bridge_with_burst.sv


# 
# parameters
# 
add_parameter ADDRESSWIDTH INTEGER 32
set_parameter_property ADDRESSWIDTH DEFAULT_VALUE 32
set_parameter_property ADDRESSWIDTH DISPLAY_NAME ADDRESSWIDTH
set_parameter_property ADDRESSWIDTH TYPE INTEGER
set_parameter_property ADDRESSWIDTH UNITS None
set_parameter_property ADDRESSWIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ADDRESSWIDTH HDL_PARAMETER true
add_parameter DATAWIDTH INTEGER 32
set_parameter_property DATAWIDTH DEFAULT_VALUE 32
set_parameter_property DATAWIDTH DISPLAY_NAME DATAWIDTH
set_parameter_property DATAWIDTH TYPE INTEGER
set_parameter_property DATAWIDTH UNITS None
set_parameter_property DATAWIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property DATAWIDTH HDL_PARAMETER true
add_parameter FIFODEPTH INTEGER 32
set_parameter_property FIFODEPTH DEFAULT_VALUE 32
set_parameter_property FIFODEPTH DISPLAY_NAME FIFODEPTH
set_parameter_property FIFODEPTH TYPE INTEGER
set_parameter_property FIFODEPTH UNITS None
set_parameter_property FIFODEPTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property FIFODEPTH HDL_PARAMETER true
add_parameter FIFODEPTH_LOG INTEGER 5
set_parameter_property FIFODEPTH_LOG DEFAULT_VALUE 5
set_parameter_property FIFODEPTH_LOG DISPLAY_NAME FIFODEPTH_LOG
set_parameter_property FIFODEPTH_LOG TYPE INTEGER
set_parameter_property FIFODEPTH_LOG UNITS None
set_parameter_property FIFODEPTH_LOG ALLOWED_RANGES -2147483648:2147483647
set_parameter_property FIFODEPTH_LOG HDL_PARAMETER true
add_parameter MAXBURSTCOUNT INTEGER 8
set_parameter_property MAXBURSTCOUNT DEFAULT_VALUE 8
set_parameter_property MAXBURSTCOUNT DISPLAY_NAME MAXBURSTCOUNT
set_parameter_property MAXBURSTCOUNT TYPE INTEGER
set_parameter_property MAXBURSTCOUNT UNITS None
set_parameter_property MAXBURSTCOUNT ALLOWED_RANGES -2147483648:2147483647
set_parameter_property MAXBURSTCOUNT HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_master
# 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock
set_interface_property avalon_master associatedReset reset
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 0
set_interface_property avalon_master maximumPendingWriteTransactions 0
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0
set_interface_property avalon_master ENABLED true
set_interface_property avalon_master EXPORT_OF ""
set_interface_property avalon_master PORT_NAME_MAP ""
set_interface_property avalon_master CMSIS_SVD_VARIABLES ""
set_interface_property avalon_master SVD_ADDRESS_GROUP ""

add_interface_port avalon_master address address Output ADDRESSWIDTH
add_interface_port avalon_master write write Output 1
add_interface_port avalon_master read read Output 1
add_interface_port avalon_master byteenable byteenable Output 4
add_interface_port avalon_master writedata writedata Output DATAWIDTH
add_interface_port avalon_master waitrequest waitrequest Input 1
add_interface_port avalon_master readdatavalid readdatavalid Input 1
add_interface_port avalon_master readdata readdata Input DATAWIDTH
add_interface_port avalon_master burstcount burstcount Output 4


# 
# connection point ahb_slave
# 
add_interface ahb_slave ahb end
set_interface_property ahb_slave associatedClock clock
set_interface_property ahb_slave associatedReset reset
set_interface_property ahb_slave ENABLED true
set_interface_property ahb_slave EXPORT_OF ""
set_interface_property ahb_slave PORT_NAME_MAP ""
set_interface_property ahb_slave CMSIS_SVD_VARIABLES ""
set_interface_property ahb_slave SVD_ADDRESS_GROUP ""

add_interface_port ahb_slave HRDATA hrdata Output DATAWIDTH
add_interface_port ahb_slave HREADY hreadyin Input 1
add_interface_port ahb_slave HRESP hresp Output 2
add_interface_port ahb_slave HBURST hburst Input 3
add_interface_port ahb_slave HSIZE hsize Input 3
add_interface_port ahb_slave HTRANS htrans Input 2
add_interface_port ahb_slave HPROT hprot Input 4
add_interface_port ahb_slave HADDR haddr Input ADDRESSWIDTH
add_interface_port ahb_slave HWDATA hwdata Input DATAWIDTH
add_interface_port ahb_slave HWRITE hwrite Input 1
add_interface_port ahb_slave HREADYOUT hready Output 1
add_interface_port ahb_slave HSEL hsel Input 1

