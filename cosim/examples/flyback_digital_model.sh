#!/bin/sh
MODEL_TECH=~/altera/13.1/modelsim_ase

function killit {
   echo "FAILED!"
   exit 1
}
trap killit ERR

# Replace with path to VPI source files
VPIPATH=../../icm/digital/d_hdl

rm -f simulator_pipe vsim.wlf
gcc -c -m32 -fPIC -I $MODEL_TECH/include $VPIPATH/d_hdl/d_hdl_vpi.c
gcc -c -m32 -fPIC -I $MODEL_TECH/include $VPIPATH/d_hdl/d_hdl_vlog.c
ld -melf_i386 -shared -E -od_hdl_vpi.so d_hdl_vpi.o d_hdl_vlog.o
$MODEL_TECH/bin/vlib work
$MODEL_TECH/bin/vlog flyback_digital.v
echo "run -all" | \
   $MODEL_TECH/bin/vsim -wlf vsim.wlf -pli d_hdl_vpi.so flyback_digital
