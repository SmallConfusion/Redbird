extends Button
class_name LoadButton

@export var level := 0
@export var focus := false

var scene_manager

func init(scene):
	scene_manager = scene


func _ready():
	if focus:
		grab_focus()
	
	connect("focus_exited", _focus_exited)

func _focus_exited():
	SoundManager.play("menu", "input")

func _pressed():
	scene_manager.load_level(level)
	SoundManager.play("menu", "select")
