################################################################################
#
# the synthesis scripts
#
################################################################################



################################################################################
#
# environment setup
#
################################################################################

#directories for EDA-tools and cell library
source eda_env.tcl
set cell_lib_path "$STDCELL_DB_DIR"

#directory of RTL source code
#set work_dir ".."
set rtl_dir "../rtl"

#the search path for everything
set search_path " ., $cell_lib_path, $rtl_dir"



################################################################################
#
# setup the logical library
#
################################################################################

set target_library ./saed32lvt_ff0p85v25c.db
set link_library "* $target_library"



################################################################################
#
# setup the physical library
#
################################################################################

create_mw_lib	\
-technology $STDCELL_MW_LIB/saed32nm_1p9m_mw.tf	\
	-mw_reference_library ./saed32nm_lvt_1p9m	\
	my_mw_design

open_mw_lib my_mw_design

set_tlu_plus_files	\
	-max_tluplus $STDCELL_RCXT_LIB/saed32nm_1p9m_Cmax.tluplus	\
	-min_tluplus $STDCELL_RCXT_LIB/saed32nm_1p9m_Cmin.tluplus	\
	-tech2itf_map $STDCELL_RCXT_LIB/saed32nm_tf_itf_tluplus.map



################################################################################
#
# read design files
#
################################################################################

read_file -format verilog acc.v
read_file -format verilog target_design.v



################################################################################
#
# define the design environment
#
################################################################################

set_operating_conditions ff0p85v25c
#set_wire_load_model -name "8000"



################################################################################
#
# set design constraints
#
################################################################################

create_clock -name clk -period 10 [get_ports clk]
set_dont_touch_network [get_clocks clk]
set_fix_hold [get_clocks clk]



################################################################################
#
# compile the design and report
#
################################################################################

compile_ultra -only_design_rule -incremental
extract_rc -estimate

report_area > acc.area.rpt
report_timing > acc.timing.rpt
report_constraint -all_violators

write_file -format verilog -hierarchy -output target_design.vg
write_file -format ddc -output target_design.ddc
write_sdc target_design.sdc
write_parasitics -output target_design.spf
write_sdf target_design.sdf
write_sdf -instance u_accumulator u_acc.sdf
write_milkyway -output target_design

close_mw_lib

exit
