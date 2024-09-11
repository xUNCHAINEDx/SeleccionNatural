extends Node

signal progesss_changed(progress)
signal load_done

var _load_screen_path : String = "res://pantallaDeCarga/loading_screen.tscn"
var _load_screeen = load(_load_screen_path)
var _loaded_resource: PackedScene
var _scene_path: String
var _progress: Array = []

var use_sub_threads : bool = true 

func load_scene(scene_path: String) -> void:
	_scene_path = scene_path
	
	var new_loading_screen = _load_screeen.instantiate()
	get_tree().get_root().add_child(new_loading_screen)
	
	self.progesss_changed.connect(new_loading_screen._update_progress_bar)
	self.load_done.connect(new_loading_screen._start_outro_animation)
	
	await Signal(new_loading_screen, "loading_screeen_has_full_coverage")
	
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(_scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)
		
func _process(_delta):
	var load_status = ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	match load_status: 
		0, 2: #? TREAD_LOAD_INVALOID_RESURCE, TREAD_LOAD_FAILED
			set_process(false)
			return
		1: #'TREAD_LOAD_IN_PROGRESS
			emit_signal("progesss_changed", _progress[0])
		3: #? TREAD_LOAD_LOADED
			_loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			emit_signal("progesss_changed", 1.0)
			emit_signal("load_done")
			get_tree().change_scene_to_packed(_loaded_resource)
	
