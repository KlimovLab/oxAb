
# addgroup needs atomid
set upperlayer [addgroup {366 484 602 720 838 956 1074 1192 1310 1428 1546 1664 1782 1900 2018 2136 2254 2372 2490 2608 2726 2844 2962 3080 3198 3316 3434 3552 3670 3788 3906 4024 4142 4260 4378 4496 8862 8980 9098 9216 9334 9452 10278 10396 10514 10632 10750 10868 11694}]
set lowerlayer [addgroup {4614 4732 4850 4968 5086 5204 5322 5440 5558 5676 5794 5912 6030 6148 6266 6384 6502 6620 6738 6856 6974 7092 7210 7328 7446 7564 7682 7800 7918 8036 8154 8272 8390 8508 8626 8744 9570 9688 9806 9924 10042 10160 10986 11104 11222 11340 11458 11576 11812}]

# spring constant
set k 6.5

# set distance between P-P
set d 34.73617
set ddiv2 [expr $d / 2.]

# required function
proc calcforces {} {
 # load in atom coordinates (add group computes COM)
 global upperlayer lowerlayer k ddiv2
 loadcoords coord
 
 # constraint between cm1 and cm2 of phosphate atoms in bilayer
 set cm1 [split $coord($upperlayer) { }]
 set cm2 [split $coord($lowerlayer) { }]
 set cm1_z [lindex $cm1 2]
 set cm2_z [lindex $cm2 2]
 set r_cm1_d [expr $cm1_z-$ddiv2]
 set r_cm2_d [expr $cm2_z+$ddiv2]
 set f_cm1_z [expr -$k*$r_cm1_d]
 set f_cm2_z [expr -$k*$r_cm2_d]
 addenergy [expr 0.5*$k*$r_cm1_d**2.0]
 addenergy [expr 0.5*$k*$r_cm2_d**2.0]
 addforce $upperlayer [list 0.0 0.0 $f_cm1_z]
 addforce $lowerlayer [list 0.0 0.0 $f_cm2_z]

 # print com
 #print cm1_z=$cm1_z
 #print cm2_z=$cm2_z
}
