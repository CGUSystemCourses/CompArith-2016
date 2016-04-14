################################################################################
#
# Makefile for [testsuits/tg13::ts01-LRF_flow/st05-presim_basic]
#
################################################################################

default: analysis



################################################################################
#
# detect and setup the environment
#
################################################################################

### to get project environment ###

updir1 = $(abspath $(PWD)/..)
updir2 = $(abspath $(updir1)/..)
updir3 = $(abspath $(updir2)/..)
updir4 = $(abspath $(updir3)/..)

DEMO_ROOT = $(updir1)



################################################################################
#
# setup simulation support from the cell library
#
################################################################################

EDA_ROOT = /usr/local/eda_tools
CELL_LIB_ROOT = /usr/local/cell_lib
SAED_CELLS_ROOT = $(CELL_LIB_ROOT)/SAED32_EDK

SAED_SIM_DIR = $(SAED_CELLS_ROOT)/lib/stdcell_lvt/verilog
SAED_SIM_FILE += saed32nm_lvt.v

CELL_LINK += $(addsuffix .cell_link, $(SAED_SIM_FILE))

%.cell_link:
	ln -fs $(SAED_SIM_DIR)/$*

$(SAED_SIM_FILE): $(CELL_LINK)

link_cell_lib: $(SAED_SIM_FILE)

clean_cell_lib:
	rm -f $(SAED_SIM_FILE)



################################################################################
#
# setup design files
#
################################################################################

EXP_ROOT = $(updir1)
SYN_DIR = $(EXP_ROOT)/d01-synth

DESIGN_SRC_FILE += target_design.vg
DESIGN_SRC_FILE += acc.vinc
DESIGN_SRC_FILE += target_design.spf target_design.sdc

%.vg:
	ln -fs $(SYN_DIR)/$@

%.vinc:
	ln -fs $(DEMO_ROOT)/rtl/$@

%.spf:
	ln -fs $(SYN_DIR)/$@

%.sdc:
	ln -fs $(SYN_DIR)/$@

design_src: $(DESIGN_SRC_FILE)

clean_design_src:
	rm -f $(DESIGN_SRC_FILE)



################################################################################
#
# setup test patterns
#
################################################################################

TEST_INC_FILES += 
TEST_MODULES += $(wildcard *.v)

EXE_FILES += $(TEST_MODULES:.v=.exe)
OUTPUT_FILES += $(TEST_MODULES:.v=.out)
DIFF_FILES += $(TEST_MODULES:.v=.diff)



################################################################################
#
# execution rules
#
################################################################################

#the verilog compiler/simulator
VERILOG ?= vcs

#flags to verilog compiler
SIM_FLAGS = -q
INC_DIRS += $(DESIGN_INC_DIR) $(TEST_INC_DIR)
INC_FLAGS = $(addprefix +incdir+, $(INC_DIRS))
DEBUG_FLAGS = -I
MACROS += 
MACRO_FLAGS += $(addprefix +define+, $(MACROS))

VERILOG_FLAGS += -full64
VERILOG_FLAGS += +v2k $(INC_FLAGS) +libext+.v+ $(DEBUG_FLAGS) $(MACRO_FLAGS)
VERILOG_FLAGS += -timescale=1ns/10ps

%.exe: $(DESIGN_SRC_FILE) %.v $(SAED_SIM_FILE)
	$(VERILOG) $(VERILOG_FLAGS) -o $@ $(filter %.vg %.v, $^)

%.out: %.exe
	./$< -q > $@

%.diff: %.out
	diff --unified=100 -b -i -B $< $*.gold > $@



################################################################################
#
# analysis
#
################################################################################

ANALYSIS_SCRIPT = analysis.pt.tcl
CELL_LIB = saed32lvt_ff0p85v25c.db

%.db:
	ln -fs $(SYN_DIR)/$@

analysis: presim.out $(ANALYSIS_SCRIPT) $(CELL_LIB)
	pt_shell -f $(ANALYSIS_SCRIPT)

clean_analysis:
	rm -f *.rpt
	rm -f $(CELL_LIB)
	rm -f *.log



################################################################################
#
# the user interface
#
################################################################################

all: $(EXE_FILES)

run: $(OUTPUT_FILES)

check: $(DIFF_FILES)

clean: clean_cell_lib clean_design_src clean_analysis
	rm -f *.exe
	rm -f *.out
	rm -f *.vpd
	rm -rf *.exe.daidir
	rm -rf csrc
	rm -f ucli.key
	rm -rf DVEfiles
	rm -f *.diff





