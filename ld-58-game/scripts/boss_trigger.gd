extends Area2D

var in_boss_trigger = false


func _on_body_entered(body) -> void:
	if body.name == "Player":
		print("entered boss area")
		in_boss_trigger = true
	pass # Replace with function body.


func _on_body_exited(body) -> void:
	if body.name == "Player":
		print("left boss area")
		in_boss_trigger = false
	pass # Replace with function body.
