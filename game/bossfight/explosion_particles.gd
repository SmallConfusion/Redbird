extends GPUParticles2D

@export var autoplay := false

func _ready():
	if autoplay:
		start()

func start():
	emitting = true
	$GPUParticles2D.emitting = true
