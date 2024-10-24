extends Panel

var temporizador = 3
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

#para intentar limitar las graficas
@onready var label_año : Label = $Label3
@onready var barra_melanicas : Control = $Label  
@onready var barra_oscuras : Control = $Label2  

func _ready() -> void:

	actualizar_año()

func actualizar_año() -> void:
	label_año.text = "Año " + str(Conteo.Año)  
	
func _on_timer_timeout() -> void:
	temporizador -= 1
	if temporizador == 0:
		animationPlayer.play("fade_out")
		if Conteo.NivelActual == 0:
			Conteo.NivelActual = 1
			Conteo.Año = 1  # Cambiamos el año a 1
			actualizar_año()  # Actualizamos el label
			LoadManager.load_scene("res://SegundoNivel/SegundoNivel.tscn")
			Conteo.Año = 2 
		elif Conteo.NivelActual == 1:
			Conteo.NivelActual = 2 
			actualizar_año() 
			print("cambio de nivel")
			get_tree().quit()
