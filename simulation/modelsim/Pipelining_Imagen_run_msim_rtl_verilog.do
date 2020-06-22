transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Work\ Files/Arquitectura\ de\ Computadores\ I/ProyectoGrupalI {D:/Work Files/Arquitectura de Computadores I/ProyectoGrupalI/data_memory.v}
vlog -sv -work work +incdir+D:/Work\ Files/Arquitectura\ de\ Computadores\ I/ProyectoGrupalI {D:/Work Files/Arquitectura de Computadores I/ProyectoGrupalI/data_memory_tb.sv}

