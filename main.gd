extends Control

var debug_mode = false

func _ready():
	load_main()
	MusicManager.updated.connect(on_music_manager_updated)
	
	if not OS.is_debug_build():
		$DebugWindow.queue_free()
	
	$DebugWindow.visible = false


func _process(_delta):
	if Input.is_action_just_pressed("Debug"):
		$DebugWindow.visible = not $DebugWindow.visible


func load_main():
	var instance = preload("res://game/test.tscn").instantiate()
	%SubViewport.add_child(instance)


func on_music_manager_updated():
	MusicManager.play("music", "main", 0)

