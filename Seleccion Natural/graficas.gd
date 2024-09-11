extends Node2D

# Datos para el gráfico de barras
var data = [Conteo.G_claras, Conteo.G_melanicas, Conteo.G_Oscuras]
var labels = ["Dato 1", "Dato 2", "Dato 3"]
var colors = [Color.YELLOW, Color.CORAL, Color.GRAY]

# Parámetros del gráfico
var bar_width = 50
var bar_gap = 50
var start_x = 210
var start_y = 280
var height_scale = 20  # Escalar la altura de las barras
var font_size = 20    # Tamaño de la fuente para las etiquetas
var number_font_size = 30  # Tamaño de la fuente para el número grande

func _draw():
	# Cargar la fuente predeterminada
	var font = load("res://fonts/defaultr.ttf")
	
	# Cálculo para centrar las barras
	var total_width = (bar_width + bar_gap) * data.size() - bar_gap
	var start_x_centered = start_x - total_width / 2

	for i in range(data.size()):
		var bar_height = data[i] * height_scale
		var bar_x = start_x_centered + i * (bar_width + bar_gap)
		var bar_y = start_y - bar_height

		# Dibujar la barra
		draw_rect(Rect2(bar_x, bar_y, bar_width, bar_height), colors[i])
