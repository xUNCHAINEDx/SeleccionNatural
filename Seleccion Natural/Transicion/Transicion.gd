extends CanvasLayer

signal transicion 

func transicion_escena():
	$AnimationPlayer.play("fade_to_screen")
#func transicion_nivel():
#	$AnimationPlayer.play("Fade_to_normal ")

func transicion_nivel():
	$AnimationPlayer.play("Fade_to_normal ")

func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "fade_to_screen":
		emit_signal("transicion")
		$AnimationPlayer.play("Fade_to_normal")
