extends Control

var scene_manager


func init(scene):
	scene_manager = scene


func _ready():
	for button in get_children(true):
		if button is LoadButton:
			button.init(scene_manager)
