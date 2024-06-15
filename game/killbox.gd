extends Area2D



func _on_area_entered(area):
	if area.has_method("destroy"):
		area.destroy()
	else:
		print("Warning: Tried to destroy something without destroy method")
