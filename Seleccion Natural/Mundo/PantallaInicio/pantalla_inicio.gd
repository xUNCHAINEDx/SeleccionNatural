extends Node2D



func _on_jugar_button_down() -> void:
	LoadManager.load_scene("res://Mundo/Niveles/Niveles.tscn")

func _on_salir_button_down() -> void:
	get_tree().quit()
