set_svf "mul.svf"
set search_path " /home/synopsys/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn65gplushpbwp_140a ./ " ;

set TARGET_LIBRARY_FILES     tcbn65gplushpbwptc.db   ;#  Logical technology library file

##########################################################################################
# User-defined variables for physical library setup in dc_setup.tcl
##########################################################################################

set MW_DESIGN_LIB        MY_DESIGN_LIB                 ;# User-defined Milkyway design library name

set MW_REFERENCE_LIB_DIRS   /home/synopsys/TSMCHOME/digital/Back_End/milkyway/tcbn65gplushpbwp_140a/frame_only/tcbn65gplushpbwp  ;# Milkyway reference libraries

set TECH_FILE /home/synopsys/TSMCHOME/digital/Back_End/milkyway/tcbn65gplushpbwp_140a/techfiles/tsmcn65_9lmT2.tf   ;#  Milkyway technology file

set TLUPLUS_MAX_FILE  /home/synopsys/TSMCHOME/digital/Back_End/milkyway/tcbn65gplushpbwp_140a/techfiles/tluplus/cln65g+_1p09m+alrdl_rcworst_top2.tluplus ;#Max TLUPlus file

set TLUPLUS_MIN_FILE   /home/synopsys/TSMCHOME/digital/Back_End/milkyway/tcbn65gplushpbwp_140a/techfiles/tluplus/cln65g+_1p09m+alrdl_rcbest_top2.tluplus ;#Max TLUPlus file

set MAP_FILE   /home/synopsys/TSMCHOME/digital/Back_End/milkyway/tcbn65gplushpbwp_140a/techfiles/tluplus/star.map_9M ;#  Mapping file for TLUplus


######################################################################
# Logical Library Settings
######################################################################
set_app_var search_path "$search_path  "
set_app_var target_library $TARGET_LIBRARY_FILES
set_app_var link_library "* $target_library "

######################################################################
# Physical Library Settings
######################################################################

set_app_var mw_reference_library $MW_REFERENCE_LIB_DIRS
set_app_var mw_design_library $MW_DESIGN_LIB

# Only create new Milkyway design library if it doesn't already exist
    if {![file isdirectory $mw_design_library ]} {
      create_mw_lib   -technology $TECH_FILE \
                      -mw_reference_library $mw_reference_library \
                      $mw_design_library
    } else {
# If Milkyway design library already exists, continue by opening the existing library
    }

open_mw_lib     $mw_design_library
check_library
set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -min_tluplus $TLUPLUS_MIN_FILE \
-tech2itf_map $MAP_FILE

check_tlu_plus_files


read_verilog mult16x16.v
current_design mult16x16   #top module name of the verilog file   
link
check_design
source mult16x16.sdc
check_timing
set_load 1 [all_outputs]
set_scan_configuration -style multiplexed_flip_flop 
compile_ultra -scan 
check_design
set test_default_strobe 1
set test_default_period 3
set_dft_signal -view existing_dft -type ScanClock -timing [list 2 3] -port clk
set_dft_signal -view existing_dft -port rstn -type Reset -active_state 0
create_port si -dir IN
set_dft_signal -view spec -port si -type ScanDataIn 
create_port so -dir OUT
set_dft_signal -view spec -port so -type ScanDataOut 
create_port se -dir IN
set_dft_signal -view spec -port se -type ScanEnable 
create_test_protocol
dft_drc
set_scan_configuration -chain_count 1
preview_dft
insert_dft
dft_drc -coverage_estimate

write_test_protocol -o scan1.spf
# Write the ddc design
write -format ddc -hierarchy -output scan2.ddc
write_sdf time_1.sdf
write_parasitics   
write -hierarchy -format verilog -output "mult16x16_scan.v"

catch {file mkdir report}
report_area -hierarchy > report/area.rpt
report gates > report/s27.rpt
report_power > report/power.rpt
report_timing > report/timing.rpt
report_timing -delay_type min
report_net > report/net.rpt
report_port > report/port.rpt
report_constraint > report/con_1.sdc
report_qor > report/qor.rpt
report_timing -delay_type min
write_parasitics -report -output report/parasitics.rpt
write_parasitics -output report/parasitics.spef