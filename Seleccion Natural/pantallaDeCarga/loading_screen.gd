extends CanvasLayer

signal loading_screeen_has_full_coverage

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var progressBar : ProgressBar = $Sprite2D/ProgressBar

func _update_progress_bar(new_value: float) -> void:
	progressBar.set_value_no_signal(new_value * 100)

func _start_outro_animation() -> void:
	await Signal(animationPlayer, "animation_finished")
	animationPlayer.play("end_load")
	await Signal(animationPlayer, "animation_finished")
	self.queue_free()
