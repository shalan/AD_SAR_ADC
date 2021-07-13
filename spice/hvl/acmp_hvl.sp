.include SKY130A.sp
.include hvl.spice


.subckt latch_nor3 CLK VP VN VGND VNB VPB VPWR Q Qb
	x1 CLK VP Q VGND VNB VPB VPWR Qb sky130_fd_sc_hvl__nor3_1
	x2 CLK VN Qb VGND VNB VPB VPWR Q sky130_fd_sc_hvl__nor3_1
	*x3 Q0 VGND VNB VPB VPWR Q sky130_fd_sc_hvl__buf_4
	*x4 Q0b VGND VNB VPB VPWR Qb sky130_fd_sc_hvl__buf_4
.ends

.subckt latch_nand3 CLK VP VN VGND VNB VPB VPWR Q Qb
	x1 CLK VP Q0 VGND VNB VPB VPWR Q0b sky130_fd_sc_hvl__nand3_1
	x2 CLK VN Q0b VGND VNB VPB VPWR Q0 sky130_fd_sc_hvl__nand3_1
	x3 Q0 VGND VNB VPB VPWR Qb sky130_fd_sc_hvl__inv_4
	x4 Q0b VGND VNB VPB VPWR Q sky130_fd_sc_hvl__inv_4
.ends


** 0.85 to 3.15V Analog Latched Comparator
** was able to extend the range from 0.85-2.35 to 0.85-3.15 by increasing the inv size to 4
** Actually it is function from 0.9 to 3.3, make sure that VN does not go below 0.9
.subckt acmp CLK VP VN VGND VNB VPB VPWR Q
	x0 CLK VGND VNB VPB VPWR CLKB sky130_fd_sc_hvl__inv_1
	
	x1 CLK VP VN VGND VNB VPB VPWR Q1 Q1b latch_nand3
	x2 CLKB VP VN VGND VNB VPB VPWR Q2 Q2b latch_nor3
		
	x5 Q1b Q2b Qb VGND VNB VPB VPWR Q sky130_fd_sc_hvl__nor3_1
	x6 Q1 Q2 Q VGND VNB VPB VPWR Qb sky130_fd_sc_hvl__nor3_1
.ends

