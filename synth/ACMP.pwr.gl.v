/* Generated by Yosys 0.9 (git sha1 UNKNOWN, clang 12.0.0 -fPIC -Os) */

(* cells_not_processed =  1  *)
(* src = "../verilog/rtl/ACMP.v:1" *)
module ACMP(clk, INP, INN, VDD, VSS, Q, VGND, VNB, VPB, VPWR);
  input  VPWR;
  input  VGND;
  input  VPB ;
  input  VNB ;
  (* src = "../verilog/rtl/ACMP.v:8" *)
  input INN;
  (* src = "../verilog/rtl/ACMP.v:7" *)
  input INP;
  (* src = "../verilog/rtl/ACMP.v:11" *)
  output Q;
  (* src = "../verilog/rtl/ACMP.v:9" *)
  input VDD;
  (* src = "../verilog/rtl/ACMP.v:10" *)
  input VSS;
  (* src = "../verilog/rtl/ACMP.v:6" *)
  input clk;
  (* src = "../verilog/rtl/ACMP.v:19" *)
  wire clkb;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net1;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net2;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net3;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net4;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net5;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net6;
  (* src = "../verilog/rtl/ACMP.v:20" *)
  wire net7;
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:84" *)
  sky130_fd_sc_hd__nor3_1 x10 (
    .A(net5),
    .B(net1),
    .C(net7),
    .Y(Q)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:92" *)
  sky130_fd_sc_hd__nor3_1 x11 (
    .A(Q),
    .B(net6),
    .C(net2),
    .Y(net7)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:28" *)
  sky130_fd_sc_hd__inv_1 x15 (
    .A(clk),
    .Y(clkb)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:52" *)
  sky130_fd_sc_hd__inv_1 x2 (
    .A(net3),
    .Y(net6)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:60" *)
  sky130_fd_sc_hd__inv_1 x3 (
    .A(net4),
    .Y(net5)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:68" *)
  sky130_fd_sc_hd__o221ai_1 x6 (
    .A1(INP),
    .A2(INP),
    .B1(clk),
    .B2(VSS),
    .C1(net4),
    .Y(net3)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:36" *)
  sky130_fd_sc_hd__a221oi_1 x7 (
    .A1(INP),
    .A2(INP),
    .B1(clkb),
    .B2(VDD),
    .C1(net2),
    .Y(net1)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:44" *)
  sky130_fd_sc_hd__a221oi_1 x8 (
    .A1(INN),
    .A2(INN),
    .B1(clkb),
    .B2(VDD),
    .C1(net1),
    .Y(net2)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "../verilog/rtl/ACMP.v:76" *)
  sky130_fd_sc_hd__o221ai_1 x9 (
    .A1(INN),
    .A2(INN),
    .B1(clk),
    .B2(VSS),
    .C1(net3),
    .Y(net4)
    , .VGND(VGND), .VNB(VNB), .VPB(VPB), .VPWR(VPWR)
  );
endmodule
