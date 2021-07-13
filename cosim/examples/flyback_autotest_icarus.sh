#!/bin/sh

function killit {
   echo "FAILED!"
   exit 1
}
trap killit ERR

# Replace with path to VPI source files
VPIPATH=../../xspice/icm/digital/d_hdl

rm -f simulator_pipe
iverilog-vpi -DD_HDL_BROKEN_CBREADWRITESYNCH \
	     $VPIPATH/d_hdl_vpi.c $VPIPATH/d_hdl_vlog.c
iverilog -oflyback_autotest.vo flyback_autotest.v
vvp -M. -md_hdl_vpi flyback_autotest.vo
