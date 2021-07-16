#
#   Author: Mohamed Shalan (mshalan@aucegypt.edu)
#

yosys -import
if [info exists env(DESIGN)] {
    set DESIGN $env(DESIGN)
} else {
    set DESIGN SAR
}

read_verilog $env(BLACKBOX)
read_verilog $DESIGN.pwr.gl.v 
write_spice ../spice/$DESIGN.sp
exit
