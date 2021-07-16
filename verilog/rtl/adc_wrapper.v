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
        | d6        | io[17]    | Input  |
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
    
    // Outputs 
    assign io_oeb[37:30] = 8'b00000000 ; 
    assign io_oeb[29]    = 1'b0 ;
    assign io_oeb[27]    = 1'b0 ;
    assign io_oeb[9]     = 1'b0 ;
    assign io_oeb[10] = 1'b0 ;

    // Inputs
    assign io_oeb[28] = 1'b1 ;
    assign io_oeb[25] = 1'b1 ;
    assign io_oeb[26] = 1'b1 ;
    assign io_oeb[24:17] = 1'b1 ;   
    assign io_oeb[9] =  1'b1 ;
    assign io_oeb[8] =  1'b1 ;
    assign io_oeb[7] =  1'b1 ;

    adc adc(
    `ifdef USE_POWER_PINS 
        .vccd1       (vccd1),
        .vssd1       (vssd1),
        .vccd2       (vccd2),
        .vssd2       (vssd2),
    `endif
        .clk        (wb_clk_i),         // The clock (digital)
        .rstn       (wb_rst_i),         // Active low reset (digital)
        .start      (io_in[28]),        // Conversion start (digital)
        .done       (io_out[29]),       // Conversion is done (digital)
        .data       (io_out[37:30]),    // SAR o/p (digital)
        .cmp_sel    (io_in[26]), 
        .cmp        (io_in[25]),
        // ACMP Ports for debugging
        .INP        (analog_io[0]),     // mprj_io[7]  (Analog)
        .INN        (analog_io[1]),     // mprj_io[8]  (Analog)
        .Q          (io_out[27]),       // mprj_io[27] (Digital)
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
