# wrapmode input
# wrapmode cell
# wrapmode nearest
# wrapmode patch ;# the default

proc calcforces {step unique k} {

 set cell [getcell]
 set z [lindex [lindex $cell 3] 2]
 set zw [expr 0.5*$z-4.0]
 #print "$z $zw"

 while {[nextatom]} {
  set atomnum [getid]

  # ABF1, atomids 1-173 (ABF1 placed above membrane in +Z)
  if {$atomnum >= 1 && $atomnum <= 173} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk > $zw} {
    set rz [expr $zk-$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   } 
  # ABF2, atomids 174-346 (ABF2 placed below membrane in -Z)
  } elseif {$atomnum >= 174 && $atomnum <= 346} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk < [expr $zw*-1.0]} {
    set rz [expr $zk+$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   }
  # ion placed above membrane in +Z
  } elseif {$atomnum == 24901} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk > $zw} {
    set rz [expr $zk-$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   }
  # ion placed below membrane in -Z
  } elseif {$atomnum == 24902} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk < [expr $zw*-1.0]} {
    set rz [expr $zk+$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   }
  # drop all other atoms from consideration
  } else {
   dropatom
   continue
  }
 }
}
