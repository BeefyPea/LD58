# pickup
extends Area2D
 
@export var item: Itemclass

func _on_body_entered(body: CharacterBody2D) -> void:
	# Assuming your player is in the "player" group.
	print("collision")
	#if body.is_in_group("player"):
		#Handmanager.add_item(item)
		#queue_free() # The item disappears after being picked up.
