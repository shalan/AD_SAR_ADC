# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

# Base Configurations. Don't Touch
# section begin
set script_dir [file dirname [file normalize [info script]]]

set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hvl"

set ::env(DESIGN_NAME) ACMP_HVL
#section end

# User Configurations
set ::env(DESIGN_IS_CORE) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/ACMP_HVL.v"

## Clock configurations
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET)  "clk"

set ::env(CLOCK_PERIOD) "10"

set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 80 100"

set ::env(PL_TARGET_DENSITY) "0.15"
set ::env(GLB_RT_MAXLAYER) 5

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0

set ::env(DIODE_INSERTION_STRATEGY) 4

set ::env(VDD_PIN) "vccd2"
set ::env(GND_PIN) "vssd2"
set ::env(VDD_NETS) [list {vccd2}]
set ::env(GND_NETS) [list {vssd2}]

set ::env(QUIT_ON_ILLEGAL_OVERLAPS) 0
