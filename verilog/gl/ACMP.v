module ACMP (INN,
    INP,
    Q,
    VDD,
    VSS,
    clk,
    vccd2,
    vssd2);
 input INN;
 input INP;
 output Q;
 input VDD;
 input VSS;
 input clk;
 input vccd2;
 input vssd2;

 sky130_fd_sc_hd__nor3_1 x10 (.A(net5),
    .B(net1),
    .C(net7),
    .Y(net12),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__nor3_1 x11 (.A(net12),
    .B(net6),
    .C(net2),
    .Y(net7),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__inv_1 x15 (.A(clk),
    .Y(clkb),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__inv_1 x2 (.A(net3),
    .Y(net6),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__inv_1 x3 (.A(net4),
    .Y(net5),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__o221ai_1 x6 (.A1(net9),
    .A2(net9),
    .B1(clk),
    .B2(net11),
    .C1(net4),
    .Y(net3),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__a221oi_1 x7 (.A1(net9),
    .A2(net9),
    .B1(clkb),
    .B2(net10),
    .C1(net2),
    .Y(net1),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__a221oi_1 x8 (.A1(net8),
    .A2(net8),
    .B1(clkb),
    .B2(net10),
    .C1(net1),
    .Y(net2),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__o221ai_1 x9 (.A1(net8),
    .A2(net8),
    .B1(clk),
    .B2(net11),
    .C1(net3),
    .Y(net4),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_0 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_1 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_2 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_3 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_4 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_5 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_6 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_7 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_8 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_9 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_10 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 PHY_11 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_12 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_13 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_14 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_15 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_16 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_17 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_18 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_19 (.VGND(vssd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__buf_1 input1 (.A(INN),
    .X(net8),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__buf_1 input2 (.A(INP),
    .X(net9),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__buf_1 input3 (.A(VDD),
    .X(net10),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(VSS),
    .X(net11),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__buf_1 output5 (.A(net12),
    .X(Q),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_input1_A (.DIODE(INN),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_input2_A (.DIODE(INP),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_input3_A (.DIODE(VDD),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_input4_A (.DIODE(VSS),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_x9_B1 (.DIODE(clk),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_x6_B1 (.DIODE(clk),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__diode_2 ANTENNA_x15_A (.DIODE(clk),
    .VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_0_3 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_0_15 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_2 FILLER_0_27 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_0_30 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_0_34 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_6 FILLER_0_38 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_0_44 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_0_47 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_0_54 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_1_3 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_8 FILLER_1_15 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_1_25 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_1_30 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_1_41 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_8 FILLER_1_48 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 FILLER_1_56 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_2_3 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_2_15 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_2_21 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_2_28 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_2_39 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_6 FILLER_2_50 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_2_56 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_2_58 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_3_6 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_8 FILLER_3_12 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_3 FILLER_3_20 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_3_25 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_3_30 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_3_41 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_3_49 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_3_55 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_4_3 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_4_15 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_8 FILLER_4_27 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_2 FILLER_4_35 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_8 FILLER_4_41 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_4_49 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_4_53 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_4_58 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_5_6 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_5_12 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_5_24 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_5_28 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_12 FILLER_5_30 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_8 FILLER_5_42 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__fill_1 FILLER_5_50 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
 sky130_fd_sc_hd__decap_4 FILLER_5_54 (.VGND(vssd2),
    .VNB(vssd2),
    .VPB(vccd2),
    .VPWR(vccd2));
endmodule
