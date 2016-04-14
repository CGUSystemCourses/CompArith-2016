################################################################################
#
# file: [tg10::ts00-acc_synth/st02-synth/analysis.pt.tcl]
#
################################################################################

set power_enable_analysis TRUE
set power_analysis_mode averaged

################################################################################
#
# environment setup
#
################################################################################

#directories for EDA-tools and cell library
source eda_env.tcl
#set cell_lib_path "$CELL_LIB_DB_DIR/sc9_base_lvt"

#directory of RTL source code
set rtl_dir "../rtl"

#the search path for everything
set search_path " ., $rtl_dir"

#set the library
set target_library ./saed32lvt_ff0p85v25c.db
set link_library "* $target_library"



################################################################################
#
# read design and simulation data
#
################################################################################

#read the netlist
read_verilog target_design.vg
current_design target_design
link

#read support data to the design
read_sdc target_design.sdc
read_parasitics target_design.spf
read_vcd target_design.vpd -strip_path main/u_target

################################################################################
#
# check timing
#
################################################################################

check_timing > target_design.time_chk.rpt
report_timing > target_design.timing.rpt

################################################################################
#
# report power
#
################################################################################

check_power > target_design.chk_power.rpt
report_power > target_design.power.rpt

exit


