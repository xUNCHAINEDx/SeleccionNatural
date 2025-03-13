extends Node2D

# Datos para el gráfico de barras
var data = [Conteo.G_claras, Conteo.G_melanicas]
var labels = ["Claras", "Melanicas"]
var colors = [Color.YELLOW, Color.CORAL]
var claras = Conteo.G_claras
var melanicas = Conteo.G_melanicas
var totales = claras + melanicas

# Parámetros del gráfico
var bar_width = 50
var bar_gap = 50
var start_x = 210
var start_y = 280
var max_height = 200  # Altura máxima de las barras en el cuadro negro

func _draw():
	# Cargar la fuente predeterminada
	var font = load("res://Assets/Fronts/Xolonium-Bold.ttf")
	
	# Obtener el valor máximo para ajustar la escala
	var max_value = max(claras, melanicas) if totales > 0 else 1 
	var height_scale = max_height / max_value
	
	# Cálculo para centrar las barras
	var total_width = (bar_width + bar_gap) * data.size() - bar_gap
	var start_x_centered = start_x - total_width / 2
	
	for i in range(2):
		var bar_height = data[i] * height_scale
		var bar_x = start_x_centered + i * (bar_width + bar_gap)
		var bar_y = start_y - bar_height

		# Dibujar la barra
		draw_rect(Rect2(bar_x, bar_y, bar_width, bar_height), colors[i])
		
		# Obtener el tamaño del texto para centrar la etiqueta debajo de la barra
		var label_size = font.get_string_size(labels[i])
		# Dibujar la etiqueta (centrada debajo de la barra)
		var label_x = bar_x + bar_width / 2 - label_size.x / 2
		var label_y = start_y + 10  # Justo debajo de la barra (ajustar 10 píxeles por debajo)
