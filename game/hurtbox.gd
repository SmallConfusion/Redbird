extends Area2D

signal hit

@export var damage := 1

var used := false

func _on_area_entered(area):
	if area.has_method("hit") and not used:
		area.hit(damage)
		used = true
		emit_signal("hit")


func destroy():
	if $"../".has_method("destroy"):
		$"../".destroy()
	else:
		print("Warning: Parent of hurtbox had no destroy method")
