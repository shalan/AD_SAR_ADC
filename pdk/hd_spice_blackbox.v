(* blackbox *)
module sky130_fd_sc_hd__buf_2 (
    A   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   , 
    X   
);
    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

// .subckt sky130_fd_sc_hd__dfrtp_4 CLK D RESET_B VGND VNB VPB VPWR Q
(* blackbox *)
module sky130_fd_sc_hd__dfrtp_4 (
    
    CLK    ,
    D      ,
    RESET_B,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Q      
);

    output Q      ;
    input  CLK    ;
    input  D      ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;
endmodule


// .subckt sky130_fd_sc_hd__dfstp_4 CLK D SET_B VGND VNB VPB VPWR Q
(* blackbox *)
module sky130_fd_sc_hd__dfstp_4 (

    CLK  ,
    D    ,
    SET_B,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Q    
);

    output Q    ;
    input  CLK  ;
    input  D    ;
    input  SET_B;
    input  VPWR ;
    input  VGND ;
    input  VPB  ;
    input  VNB  ;
endmodule

// .subckt sky130_fd_sc_hd__dfxtp_4 CLK D VGND VNB VPB VPWR Q
(* blackbox *)
module sky130_fd_sc_hd__dfxtp_4 (

    CLK ,
    D   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Q   
);

    output Q   ;
    input  CLK ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

endmodule


(* blackbox *)
module sky130_fd_sc_hd__inv_1 (
    A   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y   
);

    output Y   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__inv_2 (
    A   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y   
);

    output Y   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule


(* blackbox *)
module sky130_fd_sc_hd__nand2_4 (
    A   ,
    B   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y   
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

endmodule

(* blackbox *)
module sky130_fd_sc_hd__nand2b_2 (

    A_N ,
    B   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y  
);

    output Y   ;
    input  A_N ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__nand3_2 (

    A   ,
    B   ,
    C   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y 
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__nand4_2 (
    A   ,
    B   ,
    C   ,
    D   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__nor2_2 (
    A   ,
    B   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule


(* blackbox *)
module sky130_fd_sc_hd__nor2b_2 (
    A   ,
    B_N ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    output Y   ;
    input  A   ;
    input  B_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__nor3_1 (
    A   ,
    B   ,
    C   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule


(* blackbox *)
module sky130_fd_sc_hd__nor3_2 (
    A   ,
    B   ,
    C   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__nand3b_2 (
    A_N ,
    B   ,
    C   ,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    output Y   ;
    input  A_N ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__a221oi_1 (
    A1,
    A2,
    B1,
    B2,
    C1,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);
    // Module ports
    output Y ;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule



(* blackbox *)
module sky130_fd_sc_hd__o221ai_1 (

    A1,
    A2,
    B1,
    B2,
    C1,
    VGND   ,
    VNB    ,
    VPB    ,
    VPWR   ,
    Y
);

    // Module ports
    output Y ;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  C1;

    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
endmodule

