extends Node2D

var current_scene = null

const primer_nivel = preload("res://PrimerNivel/PrimerNivel.tscn")

func _on_Salir_button_down():
	get_tree().quit()

func _on_Jugar_button_down():
	$Transicion.transicion_escena()
	#get_tree().change_scene("res://PrimerNivel/PrimerNivel.tscn")

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	OS.center_window()

func _on_Transicion_transicion():
	get_tree().change_scene("res://PrimerNivel/PrimerNivel.tscn")
