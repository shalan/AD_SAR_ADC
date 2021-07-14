module adc(
    input   wire        clk,    // The clock (digital)
    input   wire        rstn,   // Active low reset (digital)
    input   wire        start,  // Conversion start (digital)
    output  wire        done,   // Conversion is done (digital)
    output  wire [7:0]  data,   // SAR o/p (digital)
    input   wire        cmp_sel,// 0: Internal Comparator, 1: External Comparator
    input   wire        cmp,

    // ACMP Ports for debugging
    input   wire        INP,    // (Analog)
    input   wire        INN,    // (Analog)
    output  wire        Q,       // (digital)

    // DAC ports
    input   wire        d0,
    input   wire        d1,
    input   wire        d2,
    input   wire        d3,
    input   wire        d4,
    input   wire        d5,
    input   wire        d6,
    input   wire        d7,
    input   wire        dac_inp1,
    output  wire        dac_out_v

);

    wire [7:0]  datan;
    wire        clkn;
    wire        sar_cmp = cmp_sel ? cmp : Q;
    
    ACMP COMP (
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
	

    dac_8bit DAC (
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