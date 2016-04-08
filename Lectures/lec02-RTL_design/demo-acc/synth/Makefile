################################################################################
#
# Makefile for synthesis
#
################################################################################

default: synthesis



################################################################################
#
# environment setup
#
################################################################################

### to get project environment ###

updir1 = $(abspath $(PWD)/..)
updir2 = $(abspath $(updir1)/..)
updir3 = $(abspath $(updir2)/..)

DEMO_ROOT = $(updir1)



################################################################################
#
# build the cell library
#
################################################################################

CELL_LIBS += saed32lvt_ff0p85v25c

CELL_LIB_DB_FILES += $(addsuffix .db, $(CELL_LIBS))

CELL_LIB_ROOT = /usr/local/cell_lib
SAED_LIB_ROOT = $(CELL_LIB_ROOT)/SAED32_EDK
CELL_LIB_MW_DIR = $(SAED_LIB_ROOT)/lib/stdcell_lvt/milkyway
CELL_LIB_MW = saed32nm_lvt_1p9m

CELL_LIB_SCRIPTS += eda_env.tcl build_lib.tcl

$(CELL_LIB_MW):
	ln -fs $(CELL_LIB_MW_DIR)/$(CELL_LIB_MW)

$(CELL_LIB_DB_FILES): $(CELL_LIB_SCRIPTS)
	dc_shell -f build_lib.tcl

build_cell_lib: $(CELL_LIB_DB_FILES) $(CELL_LIB_MW)

clean_db_lib:
	rm -f *.db
	rm -f $(CELL_LIB_MW)
	rm -f command.log



################################################################################
#
# logical synthesis
#
################################################################################

#basic environment setup
DW_DIR ?= 
#WORK_ROOT ?= $(SRC_ROOT)/basic_pgd_flow/acc_syn_flow

#RTL source files and directories
SRC_DIR = $(DEMO_ROOT)/rtl
RTL_INC_DIR += $(SRC_DIR) .
RTL_SRC_DIR = $(SRC_DIR)
RTL_SRC_FILES += $(foreach dir, $(RTL_SRC_DIR), $(wildcard $(dir)/*.v))
RTL_INC_FILES += $(foreach dir, $(RTL_INC_DIR), $(wildcard $(dir)/*.vinc))

#synthesis script and generated files
SYNTH_SCRIPT = synthesis.tcl
NETLIST_FILES += target_design.syn_saed32.v

SYNTH_DEP += $(RTL_INC_FILES) $(RTL_SRC_FILES) $(SYN_SCRIPT)
SYNTH_DEP += $(CELL_LIB_DB_FILES) $(CELL_LIB_MW)

$(NETLIST_FILES): $(SYNTH_DEP)
	dc_shell -topographical -f $(SYNTH_SCRIPT)

synthesis: $(NETLIST_FILES)



################################################################################
#
# export outcome
#
################################################################################

EXPORT_DIR = $(DEMO_ROOT)/d01-synth

export:
	mkdir -p $(EXPORT_DIR)
	cp target_design* $(EXPORT_DIR)
	cp *.db $(EXPORT_DIR)



################################################################################
#
# user interface
#
################################################################################

clean: clean_tmp
	rm -f *.rpt
	rm -f $(NETLIST_FILES)
	rm -f *.out
	rm -f *.vpd
	rm -f *.spf
	rm -rf my_mw_design
	rm -f *.spi
	rm -f target_design.*

clean_tmp: clean_db_lib
	rm -f *.exe
	rm -rf *.exe.daidir
	rm -rf csrc
	rm -f ucli.key
	rm -rf DVEfiles
	rm -f *.log
	rm -f default.svf
	rm -f *.sdc
	rm -f *.sdf
	rm -f *.ddc
	rm -rf alib-52
















