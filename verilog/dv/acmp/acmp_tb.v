// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

`include "uprj_netlists.v"
`include "caravel_netlists.v"
`include "spiflash.v"

`define SOC_SETUP_TIME 300_000

module acmp_tb;

  	localparam SIZE = 8;

	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

    wire gpio;
    wire [37:0] mprj_io;

	assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;
    
    // ADC Registers 
    reg start ;
    wire real INP, INN ;
    wire DONE ;
    wire Q_OUT ;
    wire [7:0] DATA_OUT ;
	wire [7:0] DAC_INP ;
	wire DAC_OUT ;
	wire cmp_sel ;
	wire cmp ;
	wire DAC_INP1 ;

    assign mprj_io[28] = start ;
    assign mprj_io[7]  = INP ;
    assign mprj_io[8]  = INN ; 
	assign mprj_io[26] = cmp_sel ;
	assign mprj_io[25] = cmp ;
	assign mprj_io[24:17] = DAC_INP ;
	assign mprj_io[9] = DAC_INP1 ;

    assign DATA_OUT = mprj_io[37:30] ;
    assign DONE  = mprj_io[29] ;
    assign Q_OUT = mprj_io[27] ;
	assign DAC_OUT = mprj_io[10] ;

	assign DAC_INP = 8'b01010101 ;
	assign DAC_INP1 = 1'b1 ;
	assign INP = Ain ;
	assign INN = Vdac ;

	// SAR 
	reg Ain, Vdac;
	wire [7:0] out; 
	wire [7:0] outn; 

	assign out = DATA_OUT ;
	assign cmp_sel = 1'b0 ;
  	assign cmp = (Ain > Vdac);
	assign outn = ~out ;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		start = 0;
		// analog input
	    Ain = 0;
		Vdac = 0;
	end

	initial begin
		$dumpfile("acmp.vcd");
		$dumpvars(0, acmp_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (25) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test ACMP (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test ACMP (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	integer i;

	initial begin
        #(`SOC_SETUP_TIME) ;
        // wait till it is out of reset   
		wait (RSTB == 1'b1) ;     
		# 300 ;		
		Ain = 0;
		Vdac = 0;
		#50 ;
		if (cmp !== Q_OUT)  begin
			$display("Monitor: Test ACMP Failed");
			$finish;
		end
		Ain = 1;
		Vdac = 0;
		#50 ;
		if (cmp !== Q_OUT)  begin
			$display("Monitor: Test ACMP Failed");
			$finish;
		end
		Ain = 0;
		Vdac = 1;
		#50 ;
		if (cmp !== Q_OUT)  begin
			$display("Monitor: Test ACMP  Failed");
			$finish;
		end
		Ain = 1;
		Vdac = 1;
		#50 ;
		if (cmp !== Q_OUT)  begin
			$display("Monitor: Test ACMP Failed");
			$finish;
		end
		`ifdef GL
	    	$display("Monitor: Test ACMP (GL) Passed");
		`else
		    $display("Monitor: Test ACMP (RTL) Passed");
		`endif
	    $finish;
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#170000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end

	always @(mprj_io) begin
		#1 $display("MPRJ-IO state = %b ", mprj_io[7:0]);
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3 = power1;
	wire VDD1V8 = power2;
	wire USER_VDD3V3 = power3;
	wire USER_VDD1V8 = power4;
	wire VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vssio	  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (USER_VDD3V3),
		.vdda2    (USER_VDD3V3),
		.vssa1	  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (USER_VDD1V8),
		.vccd2	  (USER_VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock	  (clock),
		.gpio     (gpio),
        .mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("acmp.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire