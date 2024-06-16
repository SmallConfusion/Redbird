extends CheckButton


func _ready():
	connect("focus_exited", _focus_exited)


func _focus_exited():
	SoundManager.play("menu", "input")


func _pressed():
	SoundManager.play("menu", "select")
