extends Area2D

signal hit

var damage := 1

func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit(damage)
		emit_signal("hit")
