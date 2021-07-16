export SCR=2
export CLOCK=80
export DESIGN=SAR
export BLACKBOX=../pdk/hd_spice_blackbox.v
yosys syn.tcl
perl verilog_pwr.pl $DESIGN.gl.v > $DESIGN.pwr.gl.v
yosys spice.tcl  

# Generate the ACMP spice from a handcrafted netlist
export BLACKBOX=../pdk/hd_spice_blackbox.v
export DESIGN=ACMP
yosys -o $DESIGN.gl.v -p "read_verilog $BLACKBOX  ../verilog/rtl/$DESIGN.v; flatten; splitnets; opt_clean -purge"
perl verilog_pwr.pl $DESIGN.gl.v > $DESIGN.pwr.gl.v
yosys spice.tcl  


# Generate the ACMP_HVL spice from a handcrafted netlist
export SCLIB=../pdk/sc_hvl_tt-t.lib
export DESIGN=ACMP_HVL
export BLACKBOX=../pdk/hvl_spice_blackbox.v
yosys -o $DESIGN.gl.v -p "read_verilog $BLACKBOX  ../verilog/rtl/$DESIGN.v; flatten; splitnets; opt_clean -purge"
perl verilog_pwr.pl $DESIGN.gl.v > $DESIGN.pwr.gl.v
yosys spice.tcl  


