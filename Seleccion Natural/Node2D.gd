extends Node2D

# Datos para el gráfico de barras
var data = [10, 30, 20]
var labels = ["Dato 1", "Dato 2", "Dato 3"]
var colors = [Color.red, Color.green, Color.blue]


func _draw():
	var max_value = max(data[0], data[2])
	var bar_width = 50
	var bar_gap = 20
	var start_x = 100
	var start_y = 300
	var height_scale = 5  # Escalar la altura de las barras

	for i in range(data.size()):
		var bar_height = data[i] * height_scale
		var bar_x = start_x + i * (bar_width + bar_gap)
		var bar_y = start_y - bar_height

		# Dibujar la barra
		draw_rect(Rect2(bar_x, bar_y, bar_width, bar_height), colors[i])

		# Dibujar la etiqueta del dato
		#draw_string(DefaultFont, Vector2(bar_x, start_y + 10), labels[i], Color.black)
