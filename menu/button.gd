extends Button

var scene_manager


func _ready():
	connect("focus_exited", _focus_exited)


func init(scene_manager_):
	scene_manager = scene_manager_
	_set_text()

func _focus_exited():
	SoundManager.play("menu", "input")


func _pressed():
	SoundManager.play("menu", "select")
	scene_manager.set_performance_mode(not scene_manager.performance_mode)
	_set_text()


func _set_text():
	text = "Quality %s" % ("Low" if scene_manager.performance_mode else "High")
