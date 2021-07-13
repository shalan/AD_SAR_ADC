`define UNIT_DELAY 1

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

    // Local signals
    wire buf0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    buf                                buf0        (buf0_out_X       , A                     );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, buf0_out_X, VPWR, VGND);
    buf                                buf1        (X                , pwrgood_pp0_out_X     );

endmodule


// .subckt sky130_fd_sc_hd__dfrtp_4 CLK D RESET_B VGND VNB VPB VPWR Q

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

    // Local signals
    wire buf_Q;
    wire RESET;

    //                                  Delay       Name  Output  Other arguments
    not                                             not0 (RESET , RESET_B                    );
    sky130_fd_sc_hd__udp_dff$PR_pp$PG$N `UNIT_DELAY dff0 (buf_Q , D, CLK, RESET, , VPWR, VGND);
    buf                                             buf0 (Q     , buf_Q                      );


endmodule


// .subckt sky130_fd_sc_hd__dfstp_4 CLK D SET_B VGND VNB VPB VPWR Q

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

    // Local signals
    wire buf_Q;
    wire SET  ;

    //                                  Delay       Name  Output  Other arguments
    not                                             not0 (SET   , SET_B                    );
    sky130_fd_sc_hd__udp_dff$PS_pp$PG$N `UNIT_DELAY dff0 (buf_Q , D, CLK, SET, , VPWR, VGND);
    buf                                             buf0 (Q     , buf_Q                    );

endmodule

// .subckt sky130_fd_sc_hd__dfxtp_4 CLK D VGND VNB VPB VPWR Q

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

     // Local signals
    wire buf_Q;

    //                                 Delay       Name  Output  Other arguments
    sky130_fd_sc_hd__udp_dff$P_pp$PG$N `UNIT_DELAY dff0 (buf_Q , D, CLK, , VPWR, VGND);
    buf                                            buf0 (Q     , buf_Q               );

endmodule


// .subckt sky130_fd_sc_hd__inv_2 A VGND VNB VPB VPWR Y

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

        // Local signals
    wire not0_out_Y       ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    not                                not0        (not0_out_Y       , A                     );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, not0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y     );

endmodule



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

    // Local signals
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    nand                               nand0       (nand0_out_Y      , B, A                   );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );


endmodule


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

    // Local signals
    wire not0_out         ;
    wire or0_out_Y        ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    not                                not0        (not0_out         , B                    );
    or                                 or0         (or0_out_Y        , not0_out, A_N        );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, or0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y    );
endmodule


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

        // Local signals
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    nand                               nand0       (nand0_out_Y      , B, A, C                );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );
endmodule


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

    // Local signals
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    nand                               nand0       (nand0_out_Y      , D, C, B, A             );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );

endmodule


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

     // Local signals
    wire nor0_out_Y       ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    nor                                nor0        (nor0_out_Y       , A, B                  );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nor0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y     );

endmodule

/* Primitives */
primitive sky130_fd_sc_hd__udp_dff$PR_pp$PG$N (
    Q       ,
    D       ,
    CLK     ,
    RESET   ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  CLK     ;
    input  RESET   ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    table
     //          D           CLK  RESET NOTIFIER VPWR VGND :  Qt : Qt+1
                 *            b     0      ?      1    0   :  ?  :  -    ; // data event, hold unless CP==x
                 ?           (?0)   0      ?      1    0   :  ?  :  -    ; // CP => 0, hold
                 ?            b    (?0)    ?      1    0   :  ?  :  -    ; // R => 0, hold unless CP==x
                 ?            ?     1      ?      1    0   :  ?  :  0    ; // async reset
                 0            r     ?      ?      1    0   :  ?  :  0    ; // clock data on CP
                 1            r     0      ?      1    0   :  ?  :  1    ; // clock data on CP
                 0           (x1)   ?      ?      1    0   :  0  :  0    ; // possible CP, hold when D==Q==0
                 1           (x1)   0      ?      1    0   :  1  :  1    ; // possible CP, hold when D==Q==1
                 0            x     ?      ?      1    0   :  0  :  0    ; // unkown CP, hold when D==Q==0
                 1            x     0      ?      1    0   :  1  :  1    ; // unkown CP, hold when D==Q==1
                 ?            b    (?x)    ?      1    0   :  0  :  0    ; // R=>x, hold when Q==0 unless CP==x
                 ?           (?0)   x      ?      1    0   :  0  :  0    ;
        // ['IfDef(functional)', '']                 ?            ?     ?      *      1    0   :  ?  :  -    ; // Q => - on any change on notifier
        // ['Else', '']                 ?            ?     ?      *      1    0   :  ?  :  x    ; // Q => X on any change on notifier
        // ['EndIfDef(functional)', '']                 ?            ?     ?      ?      *    ?   :  ?  :  x    ; // Q => X on any change on vpwr
                 ?            ?     ?      ?      ?    *   :  ?  :  x    ; // Q => X on any change on vgnd
    endtable
endprimitive

primitive sky130_fd_sc_hd__udp_dff$PS_pp$PG$N (
    Q       ,
    D       ,
    CLK     ,
    SET     ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  CLK     ;
    input  SET     ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    table
     //          D           CLK  SET  NOTIFIER VPWR VGND :  Qt : Qt+1
                 *            b    0      ?      1    0   :  ?  :  -    ; // data event, hold unless CP==x
                 ?           (?0)  0      ?      1    0   :  ?  :  -    ; // CP => 0, hold
                 ?            b   (?0)    ?      1    0   :  ?  :  -    ; // S => 0, hold unless CP==x
                 ?            ?    1      ?      1    0   :  ?  :  1    ; // async set
                 0            r    0      ?      1    0   :  ?  :  0    ; // clock data on CP
                 1            r    ?      ?      1    0   :  ?  :  1    ; // clock data on CP
                 0           (x1)  0      ?      1    0   :  0  :  0    ; // possible CP, hold when D==Q==0
                 1           (x1)  ?      ?      1    0   :  1  :  1    ; // possible CP, hold when D==Q==1
                 0            x    0      ?      1    0   :  0  :  0    ; // unkown CP, hold when D==Q==0
                 1            x    ?      ?      1    0   :  1  :  1    ; // unkown CP, hold when D==Q==1
                 ?            b   (?x)    ?      1    0   :  1  :  1    ; // S=>x, hold when Q==1 unless CP==x
                 ?           (?0)  x      ?      1    0   :  1  :  1    ;
        // ['IfDef(functional)', '']                 ?            ?    ?      *      1    0   :  ?  :  -    ; // Q => - on any change on notifier
        // ['Else', '']                 ?            ?    ?      *      1    0   :  ?  :  x    ; // Q => X on any change on notifier
        // ['EndIfDef(functional)', '']                 ?            ?    ?      ?      *    ?   :  ?  :  x    ; // Q => X on any change on vpwr
                 ?            ?    ?      ?      ?    *   :  ?  :  x    ; // Q => X on any change on vgnd
    endtable
endprimitive

primitive sky130_fd_sc_hd__udp_dff$P_pp$PG$N (
    Q       ,
    D       ,
    CLK     ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  CLK     ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    table
     //          D           CLK  NOTIFIER VPWR VGND :  Qt : Qt+1
                 1           (01)    ?      1    0   :  ?  :  1    ; // clocked data
                 0           (01)    ?      1    0   :  ?  :  0    ;
                 1           (x1)    ?      1    0   :  1  :  1    ; // reducing pessimism
                 0           (x1)    ?      1    0   :  0  :  0    ;
                 1           (0x)    ?      1    0   :  1  :  1    ;
                 0           (0x)    ?      1    0   :  0  :  0    ;
                 0            x      ?      1    0   :  0  :  0    ; // Hold when CLK=X and D=Q
                 1            x      ?      1    0   :  1  :  1    ; // Hold when CLK=X and D=Q
                 ?           (?0)    ?      1    0   :  ?  :  -    ;
                 *            b      ?      1    0   :  ?  :  -    ; // ignore edges on data
        // ['IfDef(functional)', '']                 ?            ?      *      1    0   :  ?  :  -    ;
        // ['Else', '']                 ?            ?      *      1    0   :  ?  :  x    ;
        // ['EndIfDef(functional)', '']                 ?            ?      ?      *    ?   :  ?  :  x    ; // any change on vpwr
                 ?            ?      ?      ?    *   :  ?  :  x    ; // any change on vgnd
    endtable
endprimitive

primitive sky130_fd_sc_hd__udp_pwrgood_pp$PG (
    UDP_OUT,
    UDP_IN ,
    VPWR   ,
    VGND
);

    output UDP_OUT;
    input  UDP_IN ;
    input  VPWR   ;
    input  VGND   ;

    table
     // UDP_IN VPWR VGND : out
          0     1    0   :  0   ;
          1     1    0   :  1   ;
          x     1    0   :  x   ;
          ?     0    0   :  x   ;
          ?     1    1   :  x   ;
          ?     x    0   :  x   ;
          ?     1    x   :  x   ;
    endtable
endprimitive