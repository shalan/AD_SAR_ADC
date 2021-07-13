////////////////////////////////////////////////////////////////////////////////
// Digital Flyback Controller
////////////////////////////////////////////////////////////////////////////////
// This is a simple circuit that takes in a clock and generates a simple PWL
// waveform to control the flyback.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

////////////////////////////////////////////////////////////////////////////////
// We need some synchronizers first. Basic building blocks
////////////////////////////////////////////////////////////////////////////////
module sync(input a_i, output reg s_o, input rst_n, input clk);
reg meta;

always @(posedge clk or negedge rst_n)
begin: BLK_SYNC
   if (!rst_n) {s_o, meta} <= 2'b00;
   else {s_o, meta} <= {meta, a_i};
end
endmodule

module sync_rst(output reg rst_n_o, input rst_async_n, input clk);
reg meta;

always @(posedge clk or negedge rst_async_n)
begin: BLK_SYNC
   if (!rst_async_n) {rst_n_o, meta} <= 2'b00;
   else {rst_n_o, meta} <= {meta, 1'b1};
end
endmodule
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Module: flyback_control
////////////////////////////////////////////////////////////////////////////////
// Main flyback control block -- purely digital for synthesis
////////////////////////////////////////////////////////////////////////////////

module flyback_control(input clk, input rst_async_n,
   input [1:0] dutycyc_async_i, output reg osc_o);

wire [1:0] dutycyc;
reg [4:0] counter;
wire period_hit;
reg drop_osc;
wire rst_n;

// We synchronize the asynchornous signals to avoid metastability issues.
sync_rst sync_rst_n_inst(.rst_n_o(rst_n), .rst_async_n(rst_async_n), .clk(clk));
sync sync_dutycyc_inst[1:0](.a_i(dutycyc_async_i), .s_o(dutycyc), .rst_n(rst_n),
   .clk(clk));

// The clock is 2MHz. We need to select a clock that should work for the
// desired output level.
always @(posedge clk or negedge rst_n)
begin: BLK_OSC
   if(!rst_n)
   begin
      osc_o <= 1'b1;
      counter <= 5'd0;
   end
   else if (period_hit)
   begin
      osc_o <= 1'b1;
      counter <= 5'd0;
   end
   else
   begin
      if (drop_osc) osc_o <= 1'b0;
      counter <= counter + 5'd1;
   end
end

// And we define the values
always @(counter or dutycyc)
begin: BLK_PERIOD
   case(dutycyc)
      2'b00: drop_osc = counter >= 5'd2;
      2'b01: drop_osc = counter >= 5'd7;
      2'b10: drop_osc = counter >= 5'd10;
      2'b11: drop_osc = counter >= 5'd15;
   endcase
end
assign period_hit = counter >= 5'd20;

endmodule

////////////////////////////////////////////////////////////////////////////////
// Module: flyback_digital
////////////////////////////////////////////////////////////////////////////////
// Connects the flyback control to the analog domain
////////////////////////////////////////////////////////////////////////////////

module flyback_digital;

// The inputs comming from the digital domain must be defined as a storage
// type so that the results comming from the Analog side can be written
// somewhere.
reg [2:0] inputs;
wire rst_async_n;
wire [1:0] dutycyc_async;
reg clk;
wire osc;

assign dutycyc_async = inputs[2:1];
assign rst_async_n = inputs[0];
flyback_control flyback_control_inst(.clk(clk), .rst_async_n(rst_async_n),
   .dutycyc_async_i(dutycyc_async), .osc_o(osc));

initial
begin
   $d_hdl_sync("simulator_pipe",
      "/opt/local/bin/ngspice -b -r flyback_digital.raw flyback_digital.sp",
      osc, inputs, clk);
end

// And we generate a VCD file so we can look at the results
initial
begin
   $dumpfile("waves.vcd");
   $dumpvars(0, flyback_digital);
end

endmodule
