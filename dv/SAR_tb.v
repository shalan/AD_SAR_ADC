// file: testbench_tb.v
// author: mshalan@aucegypt.edu
// Testbench for the parametrized SAR

`timescale 1ns/1ns

module SAR_tb;
  localparam SIZE = 8;
  reg clk;
  wire clkn;
  reg rstn;
  reg start;
  //reg cmp;
  wire cmp;
  wire [SIZE-1:0] out, outn;
  wire done;
  
  real Ain, Vdac;
  
  SAR #(.SIZE(SIZE)) 
        DUV ( 
          .clk(clk), 
          .rstn(rstn),
          .start(start), 
          .cmp(cmp),
          .out(out),
          .outn(outn),
          .done(done),
          .clkn(clkn)
        );

  // Analog COMP
  assign  cmp = (Ain > Vdac);
  
  // Active low DAC
  always @*
    Vdac = ~outn * 1.8 / (2**SIZE);


  initial begin
      $dumpfile("SAR_tb.vcd");
      $dumpvars;

  end      
  initial begin
    clk = 0;
    rstn = 0;
    start = 0;
    Ain = 0.24;
  end
          
  always #5 clk = ! clk;

  // The checker
  always @(posedge done)
    if(out == $floor(Ain/1.8*(2**SIZE)))
      $display("Ain=%f passed", Ain);
    else 
      $display("Ain=%f Failed! (got %d, should be %d)", Ain, out, $floor(Ain/1.8*(2**SIZE)));

  integer i;

  initial begin
    #100;
    @(posedge clk);
    rstn = 1;
    @(posedge clk);
    start = 1;
    @(negedge done) start = 0;
    #50;
    
    for(i=0; i<75; i=i+1) begin 
      Ain = Ain + 0.0232;
      @(posedge clk);
      start = 1;
      @(negedge done) start = 0;
      #50;
    end

    $finish;
  end

endmodule