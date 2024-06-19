extends Button

var scene_manager


func _ready():
	connect("focus_exited", _focus_exited)
	_set_text()


func _focus_exited():
	SoundManager.play("menu", "input")


func _pressed():
	SoundManager.play("menu", "select")
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	_set_text()


func _set_text():
	text = "Fullscreen"
