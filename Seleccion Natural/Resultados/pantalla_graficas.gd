extends Window

func _on_close_requested() -> void:
	LoadManager.load_scene("res://SegundoNivel/SegundoNivel.tscn")
