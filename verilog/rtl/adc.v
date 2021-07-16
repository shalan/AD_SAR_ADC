module adc(
`ifdef USE_POWER_PINS
    input wire vccd1,	        // User area 1 1.8V supply
    input wire vssd1,	        // User area 1 digital ground
    input wire vccd2,	        // User area 2 1.8V supply (analog)
    input wire vssd2,	        // User area 2 ground      (analog)
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

    // DAC Ports    
    input   wire        d0,         // DAC input data (digital)
    input   wire        d1,
    input   wire        d2,
    input   wire        d3,
    input   wire        d4,
    input   wire        d5,
    input   wire        d6,
    input   wire        d7,
    input   wire        dac_inp1,   // (Analog)
    output  wire        dac_out_v   // (Analog)

);

    ACMP_SAR COMP (
    `ifdef USE_POWER_PINS
        .vccd1       (vccd1),
        .vssd1       (vsdd1),
        .vccd2       (vccd2),
        .vssd2       (vssd2),
    `endif
        .clk(clk),
        .start(start),
        .done(done),
        .data(data),    
        .cmp_sel(cmp_sel),
        .cmp(cmp),
        .INP(INP),
        .INN(INN),
        .Q(Q),
    );

    DAC_8BIT DAC (
     `ifdef USE_POWER_PINS
        .vdd(vccd2),
        .gnd(vssd2),
    `endif 
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .d5(d5),
        .d6(d6),
        .d7(d7),
        .inp1(dac_inp1),
        .out_v(dac_out_v)
    );


endmodule