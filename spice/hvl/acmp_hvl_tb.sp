.include acmp_hvl.sp

* The testbench
V1 VPWR GND 3.3
V2 VGND GND 0.0
V3 VPB  GND 3.3
V4 VNB  GND 0.0

V5 CLK GND pulse 0 3.3 50n 1n 1n 5u 10u

v6 VN GND pwl 
	+ 0n 0.0 
	+ 0n 0.0 
	+ 100u 0.0 100u 0.2
	+ 200u 0.2 200u 0.4
	+ 300u 0.4 300u 0.6
	+ 400u 0.6 400u 0.8
	+ 500u 0.8 500u 1.0
	+ 600u 1.0 600u 1.2
	+ 700u 1.2 700u 1.4
	+ 800u 1.4 800u 1.6
	+ 900u 1.6 900u 1.8
	+ 1000u 1.8 1000u 2.0
	+ 1100u 2.0 1100u 2.2
	+ 1200u 2.2 1200u 2.4
	+ 1300u 2.4 1300u 2.6
	+ 1400u 2.6 1400u 2.8
	+ 1500u 2.8 1500u 3.0
	+ 1600u 3.0 1600u 3.2

v7 VP GND pwl
	+ 0.0n 0.0
	+ 100u 0.0 100u 0.1
	+ 1600u 3.1  

X1 CLK VP VN VGND VNB VPB VPWR COMPh acmp


.GLOBAL GND

.temp 27
.save all
.options savecurrents
.control
tran 100n 1700u
plot VP*2 VN*2 CLK+7 COMPh+12 
.endc