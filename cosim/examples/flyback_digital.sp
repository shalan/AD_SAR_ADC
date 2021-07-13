********************************************************************************
* Digital 24V flyback converter with variable output
********************************************************************************
* This flyback has a digital controller than selects sets the dutycycle to
* vary the output voltage.
********************************************************************************

* Switch Model *****************************************************************
.MODEL swmodel SW(RON=0.1 ROFF=100e6 VT=3V VH=2V)
.subckt downswitch gate drain source
rg gate swgate 10
rs swsource source 1
cbulk drain swsource 200p
switch drain swsource swgate swsource swmodel
.ends
********************************************************************************

* Transformer Model ************************************************************
.subckt transformer leftplus leftminus rightplus rightminus
L1 leftplus leftminus 120u
L2 rightplus rightminus 30u
K1 L1 L2 0.999
.ends
********************************************************************************

* Diode Model ******************************************************************
.MODEL DMODEL D(VJ=0.7)
********************************************************************************

* Bridge Models ****************************************************************
* When dealing with XSPICE digital signals we need to define what are the points
* events get generated. Therefore bridges are needed.
.MODEL bridge_3v_todig adc_bridge(in_high=2.0 in_low=1.0
+rise_delay=250n fall_delay=250n)
.MODEL bridge_3v_toana dac_bridge(out_high=2.7 out_low=0.3
+rise_delay=250n fall_delay=250n)
.MODEL bridge_12v_toana dac_bridge(out_high=12 out_low=0.12
+rise_delay=100n fall_delay=100n)

********************************************************************************
* FLYBACK Netlist
********************************************************************************

.subckt FLYBACK VSS VDD D_CLK D_RST D_DUTY1 D_DUTY0 LOAD

* We instantiate here the diode, the transformer and the switch
Dsec DPIN LOAD DMODEL
XTRANSF VDD drain VSS DPIN transformer
C2 VDD 2 100p
X1 osc drain vss downswitch
R2 2 drain 25

* The output from the digital area needs to be connected to a level shifter
* so it can drive the flyback.
ATOANA [d_osc] [osc] bridge_12v_toana

* And we place the HDL block.
* syntax: A<block> [<to digital>] [<to analog>] <clock> dm_hdl
.MODEL dm_hdl d_hdl(rise_delay=10n fall_delay=10n IC=0 DEBUG=0)
Ahdl [D_RST D_DUTY1 D_DUTY0] [d_osc] D_CLK dm_hdl
.ends

********************************************************************************
* SOURCES
********************************************************************************

* We define the usual I/Os and instantiate the flyback converter.
VSS VSS 0 0V
VDD VDD VSS 24V

* Digital Clock
* The clock is 2MHz. The reset takes just a few microseconds. The clock we
* make with a digital oscilator.
.MODEL dm_clk d_osc(cntl_array=[0 3] freq_array=[2e6 2e6]
+duty_cycle=0.5 init_phase=0)
ACLK VDD D_CLK dm_clk

* Stimuli, comes from another file. Drives dutycycle and reset
.MODEL dm_stimuli d_source(input_file="flyback_digital.txt")
ASTIMULI [D_RST D_DUTY1 D_DUTY0] dm_stimuli

********************************************************************************
* FLYBACK and LOAD
********************************************************************************

XFLYBACK VSS VDD D_CLK D_RST D_DUTY1 D_DUTY0 LOAD FLYBACK
CL LOAD RCL 4.7u
RCL RCL VSS 15m
RL LOAD VL 24
VL VL VSS 0

********************************************************************************
* Simulation Settings
********************************************************************************

.OPTIONS METHOD=GEAR
.tran 100n 2m
.save V(VDD) V(XFLYBACK.osc) V(XFLYBACK.drain) v(LOAD) v(XFLYBACK.DPIN)
.save i(VDD) i(VSS) i(VL)

.end
