# Generate the SAR spice from RTL
export SCR=2
export CLOCK=80
export DESIGN=SAR
yosys syn.tcl
perl verilog_pwr.pl $DESIGN.gl.v > $DESIGN.pwr.gl.v
yosys spice.tcl  

# Generate the ACMP spice from a handcrafted netlist
export DESIGN=ACMP
yosys -o $DESIGN.gl.v -p "read_verilog ../pdk/spice_blackbox.v  ../$DESIGN.v"
perl verilog_pwr.pl $DESIGN.gl.v > $DESIGN.pwr.gl.v
yosys spice.tcl  


