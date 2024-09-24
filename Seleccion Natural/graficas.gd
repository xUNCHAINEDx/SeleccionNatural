extends Node2D

# Datos para el gráfico de barras
var data = [Conteo.G_claras, Conteo.G_melanicas]
var labels = ["Melanicas", "Oscuras"]
var colors = [Color.YELLOW, Color.CORAL]

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
	var font = load("res://Resultados/Xolonium-Regular.ttf")

	# Cálculo para centrar las barras
	var total_width = (bar_width + bar_gap) * data.size() - bar_gap
	var start_x_centered = start_x - total_width / 2.0

	for i in range(data.size()):
		var bar_height = data[i] * height_scale
		var bar_x = start_x_centered + i * (bar_width + bar_gap)
		var bar_y = start_y - bar_height

		# Dibujar la barra
		draw_rect(Rect2(bar_x, bar_y, bar_width, bar_height), colors[i])
		
		# Dibujar el texto encima de la barra
		#draw_string(font, Vector2(bar_x, bar_y - 10), str(data[i]), font_size)
		
		# Dibujar el texto debajo de la barra
		var text_width = font.get_string_size(labels[i]).x
		var text_x = bar_x + (bar_width - text_width) / 2
		var text_y = start_y + 20  # Ajusta este valor según sea necesario
		draw_string(font, Vector2(text_x, text_y), labels[i], HORIZONTAL_ALIGNMENT_CENTER, font_size)
