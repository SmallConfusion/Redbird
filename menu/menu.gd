extends Control

var scene_manager


func init(scene):
	scene_manager = scene


func _ready():
	for button in $HBoxContainer.get_children():
		if button is LoadButton:
			button.init(scene_manager)
	
	$CheckButton.init(scene_manager)

