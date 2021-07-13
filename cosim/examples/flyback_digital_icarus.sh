#!/bin/sh

function killit {
   echo "FAILED!"
   exit 1
}
trap killit ERR

# Replace with path to VPI source files
VPIPATH=../vpi

rm -f simulator_pipe
iverilog-vpi -DD_HDL_BROKEN_CBREADWRITESYNCH \
 	     $VPIPATH/d_hdl_vpi.c $VPIPATH/d_hdl_vlog.c
iverilog -oflyback_digital.vo flyback_digital.v
vvp -M. -md_hdl_vpi flyback_digital.vo
