extends Node2D

var temporizador = 3
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _on_timer_timeout() -> void:
	temporizador -= 1  # Vamos restando de 1 en 1 el tiempo establecido (cuenta regresiva)
	
	if temporizador == 0:
		animationPlayer.play("FadeIn")
		await animationPlayer.animation_finished
		LoadManager.load_scene("res://Principal/Main.tscn")  # Carga la escena principal
