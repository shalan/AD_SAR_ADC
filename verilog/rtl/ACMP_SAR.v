module ACMP_SAR (
`ifdef USE_POWER_PINS
    input wire vccd1,	            // User area 1 1.8V supply
    input wire vssd1,	            // User area 1 digital ground
    input wire vccd2,	            // User area 2 1.8V supply (analog)
    input wire vssd2,	            // User area 2 ground      (analog)
`endif
    input   wire        clk,        // The clock (digital)
    input   wire        rstn,       // Active low reset (digital)
    input   wire        start,      // Conversion start (digital)
    output  wire        done,       // Conversion is done (digital)
    output  wire [7:0]  data,       // SAR o/p (digital)
    input   wire        cmp_sel,    // 0: Internal Comparator, 1: External Comparator (digital)
    input   wire        cmp,        // external comparison  (digital)

    // ACMP Ports 
    input   wire        INP,        // (Analog)
    input   wire        INN,        // (Analog)
    output  wire        Q,          // (digital)
);

    wire [7:0]  datan;
    wire        clkn;
    wire        sar_cmp = cmp_sel ? cmp : Q;
    
    ACMP COMP (
    `ifdef USE_POWER_PINS
        .vccd2(vccd2),
        .vssd2(vssd2),
        .VDD(vccd2),
        .VSS(vssd2),
    `endif
        .clk(clk),
        .INP(INP),
        .INN(INN),
        .Q(Q)    
    );

    SAR CTRL ( 
        .clk(clk),   
        .rstn(rstn),  
        .start(start),
        .cmp(sar_cmp),
        .out(data),    
        .outn(datan),
        .done(done),
        .clkn(clkn) 
    );
	
endmodule