extends Node2D

signal dead
signal life

@export var blink_texture : Texture2D

@export var is_dead = false


var blink_timer := 0.0
var blink_cooldown := 2.0

func _physics_process(delta):
	blink_timer -= delta
	
	if blink_timer <= 0:
		blink_timer = blink_cooldown
		blink()
		


func hit(damage):
	if not is_dead:
		SoundManager.play("boss", "die")
		is_dead = true
		emit_signal("dead")
		
		for i in range(4, 0, -1):
			$Pupil.scale = Vector2(i/4., i/4.)
			await get_tree().create_timer(0.05).timeout
		
		visible = false



func live():
	emit_signal("life")
	visible = true
	is_dead = false
	
	for i in 4:
		$Pupil.scale = Vector2((i+1.)/4., (i+1.)/4.)
		await get_tree().create_timer(0.1).timeout


func blink():
	var old_texture = $Pupil.texture
	
	$Pupil.texture = blink_texture
	await get_tree().create_timer(0.1).timeout
	$Pupil.texture = old_texture
