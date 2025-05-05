extends CanvasLayer

signal loading_screeen_has_full_coverage

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var progressBar : ProgressBar = $TextureRect/ProgressBar
var animation_playing : bool = false

func _update_progress_bar(new_value: float) -> void:
	progressBar.set_value_no_signal(new_value * 100)
	
func _on_button_button_down() -> void:
	_continue_outro_animation()
	
func _start_outro_animation() -> void:
	print("Reproduciendo animación inicial...")
	animation_playing = true
	# Reproducir la animación inicial pero no continuar automáticamente
	animationPlayer.play("fade_in")  # Asumo que tienes una animación de entrada
	
	# No usar await aquí, la continuación será manejada por el botón
	
func _continue_outro_animation() -> void:
	print("Continuando animación de salida...")
	animationPlayer.play("fade_out")
	await animationPlayer.animation_finished
	emit_signal("loading_screeen_has_full_coverage")  # Emitir la señal aquí
	queue_free()
