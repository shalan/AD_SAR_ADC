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

set ::env(DESIGN_NAME) ACMP
#section end

# User Configurations
set ::env(DESIGN_IS_CORE) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/ACMP.v"

## Clock configurations
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) "clk"

set ::env(CLOCK_PERIOD) "10"

set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 40 40"

set ::env(PL_TARGET_DENSITY) "0.15"
set ::env(GLB_RT_MAXLAYER) 5

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(FP_IO_HEXTEND) "-1"
set ::env(FP_IO_VEXTEND) "-1"
set ::env(FP_IO_HMETAL) "3"
set ::env(FP_IO_VMETAL) "4"
set ::env(FP_IO_VTHICKNESS_MULT) 8
set ::env(FP_IO_HTHICKNESS_MULT) 8

set ::env(PDN_CFG) $script_dir/pdn.tcl
set ::env(FP_PDN_CHECK_NODES) 0
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_LOWER_LAYER) "met2"
set ::env(FP_PDN_UPPER_LAYER) "met3"
set ::env(FP_PDN_HPITCH) 35
set ::env(FP_PDN_HOFFSET) 15
set ::env(FP_PDN_CORE_RING_VOFFSET) "8.5"
set ::env(FP_PDN_CORE_RING_HOFFSET) "8.5"
set ::env(FP_PDN_CORE_RING_VWIDTH) "4"
set ::env(FP_PDN_CORE_RING_HWIDTH) "4"

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0

set ::env(DIODE_INSERTION_STRATEGY) 4

set ::env(MAGIC_ZEROIZE_ORIGIN) 1

set ::env(VDD_PIN) "vccd2"
set ::env(GND_PIN) "vssd2"
set ::env(VDD_NETS) [list {vccd2}]
set ::env(GND_NETS) [list {vssd2}]