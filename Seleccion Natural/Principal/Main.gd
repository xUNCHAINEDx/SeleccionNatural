extends Node2D

signal jugar
signal salir


const primer_nivel = preload("res://PrimerNivel/PrimerNivel.tscn")

func _on_Salir_button_down():
	emit_signal("salir")

func _on_Jugar_button_down():
	#emit_signal("jugar")
	#Global.Cargando(self, "res://PrimerNivel/PrimerNivel.tscn")
	
func _ready():
	OS.center_window()
