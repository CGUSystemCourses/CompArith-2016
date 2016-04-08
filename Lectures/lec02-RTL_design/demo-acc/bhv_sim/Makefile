################################################################################
#
# Makefile for RTL simulation
#
################################################################################

default: run



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
# files and directories setup
#
################################################################################

#basic environment setup
DW_DIR ?= 

#source file directories
SRC_DIRS += $(DEMO_ROOT)/rtl
INC_DIR += $(SRC_DIRS) .
TARGET_SRC_DIR = $(SRC_DIRS)

#target source files
V_SRC_FILES += $(foreach dir, $(TARGET_SRC_DIR), $(wildcard $(dir)/*.v))
V_INC_FILES += $(foreach dir, $(INC_DIR), $(wildcard $(dir)/*.vinc))



################################################################################
#
# setup simulation tools and options
#
################################################################################

#the verilog compiler/simulator
VERILOG ?= vcs

#flags to verilog compiler
SIM_EXE_FLAGS = -q
INC_FLAGS = $(addprefix +incdir+, $(DW_DIR) $(INC_DIR))
V_DEBUG_FLAGS = -I

VERILOG_FLAGS = -full64 +v2k $(INC_FLAGS) +libext+.v+ $(V_DEBUG_FLAGS)

%.exe: $(V_INC_FILES) $(V_SRC_FILES) %.v
	$(VERILOG) $(VERILOG_FLAGS) -o $@ $(filter %.v, $^)

%.out: %.exe
	./$< > $@ 



################################################################################
#
# user interface
#
################################################################################

TARGET = rtl_sim.exe

all: $(TARGET)

run: rtl_sim.out

clean:
	rm -f *.exe
	rm -f *.out
	rm -f *.vpd
	rm -rf *.exe.daidir
	rm -rf csrc
	rm -f ucli.key
	rm -rf DVEfiles
















