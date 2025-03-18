extends Node2D

var temporizador = 3
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _on_timer_timeout() -> void:
	temporizador -= 1  # Vamos restando de 1 en 1 el tiempo establecido (cuenta regresiva)
	if temporizador == 0:
		Conteo.G_claras = 20
		Conteo.G_melanicas = 20
		Conteo.NivelActual = 0
		Conteo.Consumidas= 0
		Conteo.Limite=2
		animationPlayer.play("FadeIn")
		await animationPlayer.animation_finished
		await get_tree().create_timer(2).timeout
		LoadManager.load_scene("res://Principal/Main.tscn")  # Carga la escena principal
