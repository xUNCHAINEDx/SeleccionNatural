extends Node2D

func _on_Salir_button_down():
	get_tree().quit()

func _on_Jugar_button_down():
	LoadManager.load_scene("res://PrimerNivel/PrimerNivel.tscn")