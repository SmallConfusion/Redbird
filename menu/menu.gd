extends Control

var scene_manager

func init(scene):
	scene_manager = scene

func _process(_delta):
	if Input.is_action_just_pressed("Fire"):
		scene_manager.load_level()
