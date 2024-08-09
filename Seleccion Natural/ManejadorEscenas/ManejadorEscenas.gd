extends Node2D

const PrimerNivel = preload("res://PrimerNivel/PrimerNivel.tscn")
const SegundoNivel = preload("res://SegundoNivel/SegundoNivel.tscn")
var conexionesN1

func _on_Transicion_transicion():
	$EscenaActual.get_child(0).queue_free()
	$EscenaActual.add_child(PrimerNivel.instance())
	conexionesN1 = PrimerNivel.get_signal_connection_list("Nivel1")
	print(conexionesN1)

func _on_Main_jugar():
	$Transicion.transicion_escena()

func _on_Main_salir():
	get_tree().quit()

