# pickup
extends Area2D
 
@export var item1 = Item.new()

func _ready():
	item1.itemname = "Test Item"
	item1.description = "A basic test item."
	item1.texture = preload("res://icon.svg")

func init(item) -> void:
	item1.itemname = item.itemname
	item1.description = item.description
	item1.texture = item.texture
	
	# Use item1 as needed
func _on_body_entered(_body: CharacterBody2D) -> void:
	if Handmanager.Items.size() < 2 and Input.is_key_pressed(KEY_E) == true:
		# Assuming your player is in the "player" group.
		Handmanager.addItem(item1)
		queue_free() # The item disappears after being picked up.
