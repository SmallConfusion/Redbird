extends Area2D

func hit(damage):
	return

func destroy():
	if $"../".has_method("destroy"):
		$"../".destroy()
	else:
		print("Warning: Parent of hitbox has no destroy function")
