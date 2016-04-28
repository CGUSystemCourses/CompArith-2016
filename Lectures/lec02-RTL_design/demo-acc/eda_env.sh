#!/bin/bash

export LM_LICENSE_FILE=26585@lsncu:26585@lsntu:26585@lsnctu:26585@lsncku:26585@lsnchu:26585@lscic

#general environment
export EDA_ROOT=/usr/local/eda_tools

#environment for Synopsys design compiler
export SYNOPSYS=$EDA_ROOT/synthesis/cur
export SYNOTHESIS=$EDA_ROOT/synthesis/cur
export PATH=$PATH:$SYNOPSYS/linux/syn/bin:$SYNTHESIS/linux/bin
export PATH=$PATH:$SYNOPSYS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/libtiff3

#environment for PrimeTime
export PRIMETIME=$EDA_ROOT/primetime/cur
export PATH=$PATH:$PRIMETIME/bin:$PRIMETIME/linux/bin

#environment for Synopsys vcs
export VCS_HOME=$EDA_ROOT/vcs/cur
export PATH=$PATH:$VCS_HOME/bin
export PATH=$PATH:$VCS_HOME/linux/bin

#environment for hercules
export HERCULES_HOME=$EDA_ROOT/hercules/cur
export PATH=$PATH:$HERCULES_HOME/bin/AMD.64

#cell library setup
export CELL_LIB_ROOT=/usr/local/cell_lib
export TSMC_40_LIB=$CELL_LIB_ROOT/CBDK_TSMC40_Arm_v0.5
export TSMC40_SIM_DIR=$TSMC_40_LIB/CIC/Verilog
export TSMC40_CELL_DB=$TSMC_40_LIB/CIC/SynopsysDC/db

export SAED32_LIB=$CELL_LIB_ROOT/SAED32_EDK

#setup manual tools
export MANPATH=$MANPATH:/usr/local/eda_tools/synthesis/cur/doc/syn/man
export MANPATH=$MANPATH:/usr/local/eda_tools/synthesis/cur/doc/snps_tcl/man
export MANPATH=$MANPATH:/usr/local/eda_tools/primetime/cur/doc/pt/man
export MANPATH=$MANPATH:/usr/local/eda_tools/primetime/cur/doc/snps_tcl/man





