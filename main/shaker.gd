extends SubViewportContainer

@export var shake := 0.0

var shake_speed := 10.0
var shake_intensity := 10.0

var noise := FastNoiseLite.new()

@onready var base_pivot_offset := pivot_offset

func _ready():
	randomize()
	noise.seed = randi()

func _process(delta):
	shake -= delta
	
	if shake > 0:
		var shake_min = min(shake, 0.4)
		
		var x = noise.get_noise_1d(Time.get_ticks_msec() * shake_speed * shake_min) * shake_intensity * shake_min
		var y = noise.get_noise_1d((Time.get_ticks_msec() + 10000) * shake_speed * shake_min) * shake_intensity * shake_min

		pivot_offset = base_pivot_offset + Vector2(x, y)
	else:
		pivot_offset = base_pivot_offset


func shake_soft():
	if shake <= 0:
		shake_speed = 0.1
		shake_intensity = 25.0
		shake = 0.1


func shake_hard():
	if shake <= 0:
		shake_speed = 0.15
		shake_intensity = 35.0
		shake = 0.15


func shake_boss():
	shake_speed = 10
	shake_intensity = 7.0
	shake = 2.0
