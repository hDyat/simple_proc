onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/Resetn
add wave -noupdate /testbench/MClock
add wave -noupdate /testbench/Run
add wave -noupdate -radix hexadecimal /testbench/address
add wave -noupdate -radix octal -childformat {{{/testbench/DIN[8]} -radix octal} {{/testbench/DIN[7]} -radix octal} {{/testbench/DIN[6]} -radix octal} {{/testbench/DIN[5]} -radix octal} {{/testbench/DIN[4]} -radix octal} {{/testbench/DIN[3]} -radix octal} {{/testbench/DIN[2]} -radix octal} {{/testbench/DIN[1]} -radix octal} {{/testbench/DIN[0]} -radix octal}} -subitemconfig {{/testbench/DIN[8]} {-height 15 -radix octal} {/testbench/DIN[7]} {-height 15 -radix octal} {/testbench/DIN[6]} {-height 15 -radix octal} {/testbench/DIN[5]} {-height 15 -radix octal} {/testbench/DIN[4]} {-height 15 -radix octal} {/testbench/DIN[3]} {-height 15 -radix octal} {/testbench/DIN[2]} {-height 15 -radix octal} {/testbench/DIN[1]} {-height 15 -radix octal} {/testbench/DIN[0]} {-height 15 -radix octal}} /testbench/DIN
add wave -noupdate /testbench/Done
add wave -noupdate /testbench/PClock
add wave -noupdate -label reg_IR|Q -radix octal /testbench/p1/reg_IR/Q
add wave -noupdate /testbench/p1/Tstep_Q
add wave -noupdate -label reg_0|Q -radix hexadecimal /testbench/p1/reg_0/Q
add wave -noupdate -label reg_1|Q -radix hexadecimal /testbench/p1/reg_1/Q
add wave -noupdate -label reg_A|Q -radix hexadecimal /testbench/p1/reg_A/Q
add wave -noupdate -label reg_G|Q -radix hexadecimal /testbench/p1/reg_G/Q
add wave -noupdate -radix hexadecimal /testbench/BusWires
add wave -noupdate {/testbench/p1/Rin[0]}
add wave -noupdate {/testbench/p1/Rin[1]}
add wave -noupdate {/testbench/p1/Rout[0]}
add wave -noupdate {/testbench/p1/Rout[1]}
add wave -noupdate /testbench/p1/Gin
add wave -noupdate /testbench/p1/Gout
add wave -noupdate /testbench/p1/Ain
add wave -noupdate /testbench/p1/DINout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {166718 ps}
