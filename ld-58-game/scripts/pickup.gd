# pickup
extends Area2D
var entered = false 

@export var item1 = Item.new()
@onready var raycast: RayCast2D = $RayCast2D
func _ready():
	item1.itemname = "Test Item"
	item1.description = "A basic test item."
	item1.texture = preload("res://icon.svg")

func init(item) -> void:
	item1.itemname = item.itemname
	item1.description = item.description
	item1.texture = item.texture
	
	# Use item1 as needed

 
func _physics_process(_delta: float) -> void:
	if Handmanager.Items.size() < 2 and Input.is_key_pressed(KEY_E) == true and raycast.is_colliding() == true :
		# Assuming your player is in the "player" group.
		Handmanager.addItem(item1)
		queue_free() # The item disappears after being picked up.
