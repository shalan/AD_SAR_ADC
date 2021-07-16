#
#   Author: Mohamed Shalan (mshalan@aucegypt.edu)
#

yosys -import

set buffering   1
set sizing      1
set max_FO      5
set max_Tran    1000
set CONSTR_FILE "constr.txt"


# ABC Scrips
set abc_rs_K    "resub,-K,"
set abc_rs      "resub"
set abc_rsz     "resub,-z"
set abc_rw_K    "rewrite,-K,"
set abc_rw      "rewrite"
set abc_rwz     "rewrite,-z"
set abc_rf      "refactor"
set abc_rfz     "refactor,-z"
set abc_b       "balance"

set abc_resyn2        "${abc_b}; ${abc_rw}; ${abc_rf}; ${abc_b}; ${abc_rw}; ${abc_rwz}; ${abc_b}; ${abc_rfz}; ${abc_rwz}; ${abc_b}"
set abc_share         "strash; multi,-m; ${abc_resyn2}"
set abc_resyn2a       "${abc_b};${abc_rw};${abc_b};${abc_rw};${abc_rwz};${abc_b};${abc_rwz};${abc_b}"
set abc_resyn3        "balance;resub;resub,-K,6;balance;resub,-z;resub,-z,-K,6;balance;resub,-z,-K,5;balance"
set abc_resyn2rs      "${abc_b};${abc_rs_K},6;${abc_rw};${abc_rs_K},6,-N,2;${abc_rf};${abc_rs_K},8;${abc_rw};${abc_rs_K},10;${abc_rwz};${abc_rs_K},10,-N,2;${abc_b},${abc_rs_K},12;${abc_rfz};${abc_rs_K},12,-N,2;${abc_rwz};${abc_b}"

set abc_choice        "fraig_store; ${abc_resyn2}; fraig_store; ${abc_resyn2}; fraig_store; fraig_restore"
set abc_choice2      "fraig_store; balance; fraig_store; ${abc_resyn2}; fraig_store; ${abc_resyn2}; fraig_store; ${abc_resyn2}; fraig_store; fraig_restore"

set abc_map_old_cnt			"map,-p,-a,-B,0.2,-A,0.9,-M,0"
set abc_map_old_dly         "map,-p,-B,0.2,-A,0.9,-M,0"
set abc_retime_area         "retime,-D,{D},-M,5"
set abc_retime_dly          "retime,-D,{D},-M,6"
set abc_map_new_area        "amap,-m,-Q,0.1,-F,20,-A,20,-C,5000"

set abc_area_recovery_1       "${abc_choice}; map;"
set abc_area_recovery_2       "${abc_choice2}; map;"


if {$buffering==1} {
  set abc_fine_tune		    "buffer,-N,${max_FO},-S,${max_Tran};upsize,{D};dnsize,{D}"
} elseif {$sizing==1} {
  set abc_fine_tune         "upsize,{D};dnsize,{D}"
} else {
  set abc_fine_tune       ""
}

set scpt_dly_1          "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_resyn2};${abc_retime_dly}; scleanup;${abc_map_old_dly};retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"
set scpt_dly_2          "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_resyn2};${abc_retime_dly}; scleanup;${abc_choice};${abc_map_old_dly};${abc_area_recovery_1}; retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"
set scpt_dly_3          "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_resyn2};${abc_retime_dly}; scleanup;${abc_choice2};${abc_map_old_dly};${abc_area_recovery_2}; retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"
set scpt_dly_4         "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_resyn2};${abc_retime_area};scleanup;${abc_choice2};${abc_map_new_area};${abc_choice2};${abc_map_old_dly};retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"
set scpt_area_1         "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_resyn2};${abc_retime_area};scleanup;${abc_choice2};${abc_map_new_area};retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"
set scpt_area_2         "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_resyn2};${abc_retime_area};scleanup;${abc_choice2};${abc_map_new_area};${abc_choice2};${abc_map_new_area};retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"
set scpt_area_3         "+read_constr,${CONSTR_FILE};fx;mfs;strash;refactor;${abc_choice2};${abc_retime_area};scleanup;${abc_choice2};${abc_map_new_area};${abc_choice2};${abc_map_new_area};retime,-D,{D};${abc_fine_tune};stime,-p;print_stats -m"

set scrs(0) $scpt_dly_1
set scrs(1) $scpt_dly_2
set scrs(2) $scpt_dly_3
set scrs(3) $scpt_dly_4
set scrs(4) $scpt_area_1
set scrs(5) $scpt_area_2
set scrs(6) $scpt_area_3


set outfile [open $CONSTR_FILE w]
  puts $outfile "set_driving_cell sky130_fd_sc_hd__inv_2"
  puts $outfile "set_load 5"
close $outfile


if [info exists env(DESIGN)] {
    set DESIGN $env(DESIGN)
} else {
    set DESIGN SAR
}

if [info exists env(CLOCK)] {
    set CLOCK_PERIOD $env(CLOCK)
} else {
    set CLOCK_PERIOD 20
}

if [info exists env(SCLIB)] {
    set SCL $env(SCLIB)
} else {
    set SCL ../pdk/sc_hd_small.lib
}

if [info exists env(SYN)] {
    set SYN $env(SYN)
} else {
    set SYN 1
}

if [info exists env(SCR)] {
    set SCR $env(SCR)
} else {
    set SCR 0
}

read_liberty -lib -ignore_miss_dir -setattr blackbox $SCL

if [info exists env(VFILES)] {
    read_verilog $env(VFILES)
} else {
    read_verilog ../verilog/rtl/$DESIGN.v
}
if [info exists env(VFILES1)] {
  read_verilog $env(VFILES1)
}



hierarchy -check -top $DESIGN

if {$SYN==1} {
  synth -top $DESIGN -flatten
  dfflibmap -liberty $SCL
  abc -constr $CONSTR_FILE -D [expr int($CLOCK_PERIOD*1000)] -script $scrs($SCR) -liberty $SCL
} 
#abc -liberty $SCL

#abc -D [expr int($CLOCK_PERIOD*1000)] -liberty $SCL
#abc -liberty $SCL
#flatten
#show -stretch -prefix $DESIGN -format dot
#opt_clean -purge
#splitnets
#opt_clean -purge

opt_clean -purge
flatten
clean
stat
splitnets
opt_clean -purge
write_verilog -noattr -noexpr -nohex -nodec $DESIGN.gl.v
#write_spice $DESIGN.sp

#write_verilog -noattr -noexpr -nodec $DESIGN.gl.v
stat -top $DESIGN -liberty $SCL 

exit


