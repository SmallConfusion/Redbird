extends Control

var debug_mode = false

@export var menu : PackedScene

@export var levels : Array[PackedScene]

var loaded_node

func _ready():
	load_menu()
	MusicManager.updated.connect(on_music_manager_updated)
	
	if not OS.is_debug_build():
		$DebugWindow.queue_free()
	
	$DebugWindow.visible = false


func _process(_delta):
	if Input.is_action_just_pressed("Debug"):
		$DebugWindow.visible = not $DebugWindow.visible


func load_menu():
	load_scene(menu)


func on_music_manager_updated():
	MusicManager.play("music", "main", 0)


func load_scene(scene):
	if loaded_node:
		loaded_node.queue_free()
	
	var instance = scene.instantiate()
	
	if instance.has_method("init"):
		instance.init(self)
	else:
		print("Warning: instance has no init function")
	
	%SubViewport.add_child(instance)
	
	loaded_node = instance


# temp level load
func load_level():
	load_scene(levels[0])
