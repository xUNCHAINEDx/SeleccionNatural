extends Node2D

func _on_Button_pressed():
	get_parent().call("_on_Claras_pressed")
	queue_free()
