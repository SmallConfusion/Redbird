extends Control

var debug_mode = false

@export var menu : PackedScene

@export var levels : Array[PackedScene]

var loaded_node

var shader_t = INF

var performance_mode = false

func _ready():
	load_menu()
	MusicManager.updated.connect(on_music_manager_updated)
	
	if not OS.is_debug_build():
		$DebugWindow.queue_free()
		AudioServer.set_bus_mute(2, false)
	
	$DebugWindow.visible = false


func _process(delta):
	if Input.is_action_just_pressed("Debug"):
		$DebugWindow.visible = not $DebugWindow.visible
	
	%SceneChangeShader.material.set("shader_parameter/t", shader_t)
	shader_t += delta
	

func load_menu():
	load_scene(menu)


func on_music_manager_updated():
	MusicManager.play("music", "main", 0)


func load_scene(scene : PackedScene):
	if loaded_node:
		var texture = %SubViewport.get_texture().get_image()
		texture = ImageTexture.create_from_image(texture)
		
		%SceneChangeShader.material.set("shader_parameter/old_texture", texture)
		
		loaded_node.queue_free()
		shader_t = 0
	
	var instance = scene.instantiate()
	
	if instance.has_method("init"):
		instance.init(self)
	else:
		print("Warning: instance has no init function")
	
	loaded_node = instance
	
	await get_tree().process_frame
	
	%SubViewport.add_child(instance)


func load_level(number):
	load_scene(levels[number])


func _input(event):
	if not event is InputEventMouse:
		%SubViewport.push_input(event)

func set_performance_mode(state):
	performance_mode = state
	$PostProcessing.visible = not state
