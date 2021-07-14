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

source $script_dir/../../caravel/openlane/user_project_wrapper_empty/fixed_wrapper_cfgs.tcl

set ::env(DESIGN_NAME) user_project_wrapper
#section end

set ::env(RUN_KLAYOUT) 0 
# User Configurations
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$script_dir/../../caravel/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_project_wrapper.v"

### Black-box verilog and views
set ::env(VERILOG_FILES_BLACKBOX) "	
	$script_dir/../../caravel/verilog/rtl/defines.v \
    $script_dir/../../verilog/rtl/ACMP.v \
	$script_dir/../../verilog/rtl/SAR.v  \
	$script_dir/../../verilog/rtl/adc.v \
    $script_dir/../../verilog/rtl/adc_wrapper.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/adc_wrapper.lef"

set ::env(EXTRA_GDS_FILES) "\
	$script_dir/../../gds/adc_wrapper.gds"

## Clock configurations
set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "wb_clk_i"

set ::env(CLOCK_PERIOD) "10"

set ::env(GLB_RT_MAXLAYER) 5

set ::env(FP_PDN_CHECK_NODES)  0
set ::env(FP_PDN_ENABLE_RAILS) 0

## Internal Macros
### Macro Placement
set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro.cfg

# The following is because there are no std cells in the example wrapper project.
set ::env(SYNTH_TOP_LEVEL) 1
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(FILL_INSERTION) 0
set ::env(TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0
