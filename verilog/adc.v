module adc(
    input   wire        clk,    // The clock (digital)
    input   wire        rstn,   // Active low reset (digital)
    input   wire        start,  // Conversion start (digital)
    output  wire        done,   // Conversion is done (digital)
    output  wire [7:0]  data,   // SAR o/p (digital)

    // ACMP Ports for debugging
    input   wire        INP,    // (Analog)
    input   wire        INN,    // (Analog)
    output  wire        Q       // (Analog)
);

    wire [7:0] datan;
    wire clkn;

    
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
        .cmp(Q),
        .out(data),    
        .outn(datan),
        .done(done),
        .clkn(clkn) 
    );
	



endmodule