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
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module adc_wrapper (
`ifdef USE_POWER_PINS
    input wire vdda1,	// User area 1 3.3V supply
    input wire vssa1,	// User area 1 analog ground
    input wire vccd1,	// User area 1 1.8V supply
    input wire vssd1,	// User area 1 digital ground
    input wire vccd2,	// User area 2 1.8V supply (analog)
    input wire vssd2,	// User area 2 ground      (analog)
`endif
    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

    /*--------------------------------------*/
    /* User project is instantiated  here   */
    /*--------------------------------------*/

    /*  
    ADC PIN OUT
        ----------------------------------
        | ADC PIN   | IO        | Mode   |
        ----------------------------------
        | d7        | io[17]    | Input  |
        | d6        | io[18]    | Input  |
        | d5        | io[19]    | Input  |
        | d4        | io[20]    | Input  |
        | d3        | io[21]    | Input  |
        | d2        | io[22]    | Input  |
        | d1        | io[23]    | Input  |
        | d0        | io[24]    | Input  |
        | cmp       | io[25]    | Input  |
        | cmp_sel   | io[26]    | Input  |
        | Q         | io[27]    | Output |
        | start     | io[28]    | Input  |
        | done      | io[29]    | Output |
        | data      | io[37:30] | Output | 
        | INP       | io[7]*    | Input  | 
        | INN       | io[8]*    | Input  | 
        | dac_inp1  | io[9]*    | Input  | 
        | dac_out_v | io[10]*   | Output | 
        ----------------------------------
    */
    
    wire one, zero ; 

    assign one = ~wb_rst_i ;
    assign zero = wb_rst_i ;

    // OUT: data[0:7] 
    assign io_oeb[37:30] = {8{zero}} ; 
    // OUT: done
    assign io_oeb[29] = zero ;
    // IN : start
    assign io_oeb[28] = one ;
    // OUT: Q
    assign io_oeb[27] = zero ;
    // IN : cmp_sel
    assign io_oeb[26] =  one ;
    // IN : cmp
    assign io_oeb[25] =  one ;
    // IN : d0-d7
    assign io_oeb[24] =  one ;   
    assign io_oeb[23] =  one ;   
    assign io_oeb[22] =  one ;   
    assign io_oeb[21] =  one ;   
    assign io_oeb[20] =  one ;   
    assign io_oeb[19] =  one ;   
    assign io_oeb[18] =  one ;   
    assign io_oeb[17] =  one ;   
    // OUT : sQ
    assign io_oeb[16] =  zero ;   
    // IN : sINN
    assign io_oeb[12] = one ;    
    // IN : sINP
    assign io_oeb[11] = one ;    
    // OUT : dac_out_v
    assign io_oeb[10] = zero ;    
    // IN : dac_inp1 
    assign io_oeb[9] = one  ;
    // IN : INN
    assign io_oeb[8] =  one ;
    // IN : INP
    assign io_oeb[7] =  one ;

    adc adc(
    `ifdef USE_POWER_PINS 
        .vccd1       (vccd1),
        .vssd1       (vssd1),
        .vccd2       (vccd2),
        .vssd2       (vssd2),
    `endif
        .clk        (wb_clk_i),         // The clock (digital)
        .rst        (wb_rst_i),         // Active high reset (digital)
        .start      (io_in[28]),        // Conversion start (digital)
        .done       (io_out[29]),       // Conversion is done (digital)
        .data       (io_out[37:30]),    // SAR o/p (digital)
        .cmp_sel    (io_in[26]), 
        .cmp        (io_in[25]),
        // ACMP Ports for debugging
        .INP        (analog_io[0]),     // mprj_io[7]  (Analog)
        .INN        (analog_io[1]),     // mprj_io[8]  (Analog)
        .Q          (io_out[27]),       // mprj_io[27] (Digital)
    
        // Secondary ACMP (HVL) Ports 
        .sINP       (analog_io[4]) ,
        .sINN       (analog_io[5]) ,
        .sQ         (io_out[26]),

        // DAC Ports    
        .d0         (io_in[24]),        // DAC input data (digital)
        .d1         (io_in[23]),
        .d2         (io_in[22]),
        .d3         (io_in[21]),
        .d4         (io_in[20]),
        .d5         (io_in[19]),
        .d6         (io_in[18]),
        .d7         (io_in[17]),        
        .dac_inp1   (analog_io[2]),     // (Analog)
        .dac_out_v  (analog_io[3])      // (Analog)
    );


endmodule	// user_project_wrapper

`default_nettype wire
