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
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
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
        ---------------------------------
        | ADC PIN  | IO        | Mode   |
        ---------------------------------
        | start    | io[28]    | Input  |
        | done     | io[29]    | Output |
        | data     | io[37:30] | Output | 
        | INP      | io[7]     | Input  | 
        | INN      | io[8]     | Input  | 
        | Q        | io[9]     | Output |
        ---------------------------------
    */
    
    // Outputs 
    assign io_oeb[37:30] = 8'b00000000 ; 
    assign io_oeb[29]    = 1'b0 ;
    assign io_oeb[27]    = 1'b0 ;
    assign io_oeb[9]     = 1'b0 ;

    // Inputs
    assign io_oeb[28] = 1'b1 ;   
    assign io_oeb[7]  = 1'b1 ;
    assign io_oeb[8]  = 1'b1 ;

    adc adc(
    `ifdef USE_POWER_PINS 
        .VPWR   (vccd1),
        .VGND   (vssd1),
    `endif
        .clk    (wb_clk_i),         // The clock (digital)
        .rstn   (wb_rst_i),         // Active low reset (digital)
        .start  (io_in[28]),        // Conversion start (digital)
        .done   (io_out[29]),       // Conversion is done (digital)
        .data   (io_out[37:30]),    // SAR o/p (digital)

        // ACMP Ports for debugging
        .INP    (analog_io[0]),     // mprj_io[7]  (Analog)
        .INN    (analog_io[1]),     // mprj_io[8]  (Analog)
        .Q      (io_out[27])        // mprj_io[27] (Digital)
    );


endmodule	// user_project_wrapper

`default_nettype wire
