extends Button
class_name LoadButton

@export var level := 0
@export var last_button := false

var scene_manager

func init(scene):
	if not scene:
		print("Warning: Scene is Nil, should happen on first load.")
		return
	
	scene_manager = scene

	if level > scene_manager.unlocked_level:
		disabled = true
	elif level == scene_manager.unlocked_level or \
		(level < scene_manager.unlocked_level and last_button):
		
		print("%d level button grabbed focus" % level)
		grab_focus()

func _ready():
	connect("focus_exited", _focus_exited)

func _focus_exited():
	SoundManager.play("menu", "input")

func _pressed():
	scene_manager.load_level(level)
	SoundManager.play("menu", "select")
