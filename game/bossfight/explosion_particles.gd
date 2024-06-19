extends GPUParticles2D

@export var autoplay := false

func _ready():
	if autoplay:
		start()

func start():
	restart()
	$GPUParticles2D.restart()
	emitting = true
	$GPUParticles2D.emitting = true
