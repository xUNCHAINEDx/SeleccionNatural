extends Node2D

#CONTADORES DE LAS POLILLAS ATRAPADAS
var claras = Conteo.G_claras
var melanicas = Conteo.G_melanicas

var puntaje_claras = 0
var puntaje_melanicas = 0
var limite = 200

#DELIMITACIÓN DE LOS NIVELES
var nivel = 1
var max_niveles = 3

#DELIMITACIÓN DEL NIVEL DE JUEGO
var tiempo_por_nivel = 10
var time_mundo = tiempo_por_nivel

#DEFINICIÓN DEL TAMAÑO DE PANTALLA
var rect_width = 40
var rect_height = 15
var rect_margin = 5

var incremento_polillas = 2  #Incremento por nivel
var min_polillas = 2  #Número mínimo de polillas de cada tipo

#CARGAR LAS POLILLAS AL ESCENARIO
@onready var ClarasA = preload("res://Polillas/Claras/ClarasA.tscn")
@onready var MelanicasA = preload("res://Polillas/MelanicasA/MelanicasA.tscn")
#Aún falta carga un tipo de polilla

# Define los límites del área de generación asi ya no salen fuera del area
var min_x = 100
var max_x = 950

var min_y = 100
var max_y = 950

# Variable para almacenar las posiciones ocupadas y evitar que se encimen en la generacion
var pos_ocupada = []

# Variable para generar numeros aleatorios para el ritmo de la animacion
var rng = RandomNumberGenerator.new()

#Despliegue de la pantalla inicial
func _ready():
	#OS.center_window()
	iniciar_nivel()

#Función declarada para dar comienzo al juego (o niveles)
func iniciar_nivel():
	#tope(Conteo.Total_polillas)
	Conteo.Consumidas = 0
	var total
	Conteo.G_claras = actualizar_polillas(Conteo.G_claras)
	Conteo.G_melanicas = actualizar_polillas(Conteo.G_melanicas)
	total = Conteo.G_claras + Conteo.G_melanicas
	tope(total)
	# Obtener el tamaño del viewport correctamente
# warning-ignore:unused_variable
	var viewport_size = get_viewport().size
	randomize()	
	# Limpiar las posiciones ocupadas antes de generar nuevas polillas
	pos_ocupada.clear()
	
	generate_polillas(ClarasA, Conteo.G_claras)
	generate_polillas(MelanicasA, Conteo.G_melanicas) 
	
	#Asignar el tiemp respectivamente a cada nivel
	time_mundo = tiempo_por_nivel
	
	"""
	Nota: Para poder saber sobre que nivel estamos,
	podemos hacer que en el respectivo fondo de la escena
	aparezca un letrero indicando en que nivel nos encontramos.
	"""
#Funcion para ajustar el número de polillas en función del límite
func tope(total_polillas):
	#Conversión de los datos en formato float
	var t_polillas = float(total_polillas)
	var c_claras = float(Conteo.G_claras)
	var c_melanicas = float(Conteo.G_claras)
	#Comparación del número total de polillas con el límite
	if (total_polillas > limite):
		#Obtención de la proporción de las polillas y ajuste en función al límite
		var p_claras= (c_claras/t_polillas)
		var p_melanicas= (c_melanicas/t_polillas)
		Conteo.G_claras = p_claras*limite
		Conteo.G_melanicas = p_melanicas*limite


#Función que lleva el control de la generación de las polillas
func generate_polillas(polilla_scene, num_polillas):
# warning-ignore:unused_variable
	for j in range(num_polillas):
		var polilla_new = polilla_scene.instantiate()
		add_child(polilla_new)
		
		var pos_rand = pos_unica()
		polilla_new.position = pos_rand
		
		# Almacenar la posición ocupada
		pos_ocupada.append(pos_rand)
		
		if polilla_new.has_node("AnimatedSprite2D"):
			var animated_sprite = polilla_new.get_node("AnimatedSprite2D")
			animated_sprite.play("default") # Asegúrate de poner el nombre de tu animación aquí
			rng.randomize()
			
			# Cambia la velocidad de la animación
			animated_sprite.speed_scale = rng.randf_range(0.5, 1.5)
			
			# Empieza la animación desde un punto aleatorio
			var sprite_frames = animated_sprite.sprite_frames
			var animation_length = sprite_frames.get_frame_count("default")
			animated_sprite.frame = randi() % animation_length

# Funcion para actualizar numero de polillas
func actualizar_polillas(num_polillas_sobrevivientes):
	var num_polillas_actualizadas = num_polillas_sobrevivientes
	if (Conteo.NivelActual == 0):
		return num_polillas_actualizadas
	else:
		num_polillas_actualizadas = 3 * num_polillas_sobrevivientes
		return num_polillas_actualizadas

# Función para obtener una posición aleatoria única
func pos_unica():
	while true:
		var pos_rand = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
		var pos_valida = true
		
		# Verificar si la posición generada ya está ocupada
		for pos in pos_ocupada:
			if pos.distance_to(pos_rand) < rect_width:
				pos_valida = false
				break
		
		if pos_valida:
			return pos_rand

func _on_Timer_timeout():
	time_mundo -= 1 #Vamos restando de 1 segundo el tiempo establecido (cuenta regresiva)
	get_node("MarginContainer/VBoxContainer/Tiempo").text = "Tiempo: " + str(time_mundo)
	get_node("MarginContainer/VBoxContainer2/Nivel").text = "Año: " + str(Conteo.NivelActual)
	if time_mundo == 0:
		"""
		En un principio aquí usabamos a función:
		get_tree().quit()
		Pero ahora en esta sección se avanzara al siguiente nivel
		"""
		if Conteo.Consumidas >  10 :
			cambio_escena()
		else:
			get_tree().quit() 

func cambio_escena():
# warning-ignore:return_value_discarded
	LoadManager.load_scene("res://Resultados/PantallaGraficas.tscn")
		

func _on_ClarasA_pressed():
	Conteo.G_claras -= 1
	puntaje_claras += 1
	Conteo.Consumidas += 1
	get_node("MarginContainer/VBoxContainer/Cla").text = "CLARAS: " + str(puntaje_claras)

func _on_MelanicasA_pressed():
	Conteo.G_melanicas -= 1
	puntaje_melanicas += 1
	Conteo.Consumidas += 1
	get_node("MarginContainer/VBoxContainer/Mel").text = "MELANICAS: " + str(puntaje_melanicas)

func _draw():
	for i in range(6):
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 15), Vector2(rect_width, rect_height)), Color("478cbf"))
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 45), Vector2(rect_width, rect_height)), Color("ff0000"))
