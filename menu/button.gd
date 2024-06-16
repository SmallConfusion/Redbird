extends CheckButton

var scene_manager


func _ready():
	connect("focus_exited", _focus_exited)


func init(scene_manager_):
	scene_manager = scene_manager_
	button_pressed = scene_manager.performance_mode


func _focus_exited():
	SoundManager.play("menu", "input")


func _pressed():
	SoundManager.play("menu", "select")


func _toggled(toggled_on):
	scene_manager.set_performance_mode(toggled_on)
