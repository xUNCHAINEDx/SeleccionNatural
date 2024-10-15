extends Node2D

#CONTADORES DE LAS POLILLAS ATRAPADAS
var claras = Conteo.G_claras
var melanicas = Conteo.G_melanicas

#DELIMITACIÓN DE LOS NIVELES
var nivel = 1
var max_niveles = 3

#DELIMITACIÓN DEL NIVEL DE JUEGO
var tiempo_por_nivel = 5
var time_mundo = tiempo_por_nivel

#DEFINICIÓN DEL TAMAÑO DE PANTALLA
var rect_width = 40
var rect_height = 15
var rect_margin = 5

#NUMERO DE POLILLAS EXISTENTES AL INICIAR EL NIVEL
var num_polillas_claras = 20
var num_polillas_melanicas = 20

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
	if nivel > max_niveles:
		#En esta sección sería bueno colocar un letrero de "You win!"
		get_tree().quit()
		return
	# Obtener el tamaño del viewport correctamente
	var viewport_size = get_viewport().size
	randomize()	
	# Limpiar las posiciones ocupadas antes de generar nuevas polillas
	pos_ocupada.clear()
	
	generate_polillas(ClarasA, actualizar_polillas(Conteo.Claras_sobrevivientes))
	generate_polillas(MelanicasA, actualizar_polillas(Conteo.Melanicas_sobrevivientes))
	
	#Asignar el tiemp respectivamente a cada nivel
	time_mundo = tiempo_por_nivel
	
	"""
	Nota: Para poder saber sobre que nivel estamos,
	podemos hacer que en el respectivo fondo de la escena
	aparezca un letrero indicando en que nivel nos encontramos.
	"""
	#Contador de polillas atrapadas al iniciar el nivel

#Función que lleva el control de la generación de las polillas
func generate_polillas(polilla_scene, num_polillas):
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
	var num_polillas_actualizadas
	num_polillas_actualizadas = 1.25 * num_polillas_sobrevivientes
	if (Conteo.Total_polillas > 50):
		num_polillas_actualizadas -= 1
		print(num_polillas_actualizadas)
		print(Conteo.Total_polillas)
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
	get_node("MarginContainer/VBoxContainer2/Nivel").text = "Nivel: 2"
	if time_mundo == 0:
		"""
		En un principio aquí usabamos a función:
		get_tree().quit()
		Pero ahora en esta sección se avanzara al siguiente nivel
		"""
		cambio_escena()

		
		
func cambio_escena():
	LoadManager.load_scene("res://Resultados/PantallaGraficas.tscn")
		

func _on_ClarasA_pressed():
	Conteo.G_claras += 1
	get_node("MarginContainer/VBoxContainer/Cla").text = "CLARAS: " + str(claras)

func _on_MelanicasA_pressed():
	Conteo.G_melanicas += 1
	get_node("MarginContainer/VBoxContainer/Mel").text = "MELANICAS: " + str(melanicas)

func _draw():
	for i in range(6):
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 15), Vector2(rect_width, rect_height)), Color("478cbf"))
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 45), Vector2(rect_width, rect_height)), Color("ff0000"))
