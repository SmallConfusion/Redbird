extends Control

var scene_manager


func init(scene):
	scene_manager = scene


func _ready():
	if Time.get_ticks_msec() > 1000:
		$AnimatedSprite2D.visible = false
	
	for button in $HBoxContainer.get_children():
		if button is LoadButton:
			button.init(scene_manager)
	
	$CheckButton.init(scene_manager)

