extends Panel

var temporizador = 3
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _on_timer_timeout() -> void:
	temporizador -= 1 #Vamos restando de 1 segundo el tiempo establecido (cuenta regresiva)
	if temporizador == 0:
		animationPlayer.play("fade_out")
		LoadManager.load_scene("res://SegundoNivel/SegundoNivel.tscn")
