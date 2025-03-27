extends Panel

var NivelActual = Conteo.NivelActual
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
		

func _on_pasar_button_down() -> void:
	Conteo.NivelActual += 1
	LoadManager.load_scene("res://PrimerNivel/PrimerNivel.tscn")
