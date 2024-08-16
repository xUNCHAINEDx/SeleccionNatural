extends Node

onready var cargando_escena = preload ("res://pantallaDeCarga/cargando.tscn")

func carga_escena(escena_actual, escena_siguiente):
	var instacia_cargando_escena = cargando_escena.instance()
	get_tree().get_root().call_deferred("add_child", instacia_cargando_escena)
	
	var cargador = ResourceLoader.load_intirectative(escena_siguiente)
	
	if cargador == null:
		
		print("error ocurrido al cargar la escena")
		return
		
	escena_actual.queue_free()
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	while true:
		var error = cargador.poll()
		
		if error == OK:
			
			var progress_bar = instacia_cargando_escena.get_node("ProgressBar")
			progress_bar.value = float(cargador.get_stage()/cargador.get_stage_count() * 100)
			
		elif error == ERR_FILE_EOF:
			
			var escena = cargador.get_resouce().instance()
			
			get_tree().get_root().call_deferred("add_child", escena)
			
			instacia_cargando_escena.queue_free()
			return
		else:
			print("error ocurrido al cargar la escena")
			
			return
			
		yield(get_tree().create_timer(1.5), "timeout")
