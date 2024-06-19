extends Control

var scene_manager


func init(scene):
	scene_manager = scene


func _ready():
	if not scene_manager.first_menu:
		$AnimatedSprite2D.visible = false
	
	scene_manager.first_menu = false
	for button in $HBoxContainer.get_children():
		if button is LoadButton:
			button.init(scene_manager)
	
	$CheckButton.init(scene_manager)


func _process(delta):
	if scene_manager.unlocked_level >= 4:
		$Animation/Egg3.visible = false
		$Animation/AnimatedSprite2D2.visible = false

