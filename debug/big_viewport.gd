extends SubViewport


func _ready():
	world_2d = %SubViewport.world_2d
	

func _process(delta):
	var cameras = get_tree().get_nodes_in_group("camera")
	
	if cameras:
		$Camera2D.position = cameras[0].position
