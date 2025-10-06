# pickup
extends Area2D
@export var item1 = Item.new()
var player_colliding = false
@onready var pickup: Area2D = $"."


func _ready():
	item1.description = "A basic test item."

func init(item) -> void:
	item1.itemname = item.itemname
	item1.description = item.description
	item1.texture = item.texture
	var sprite: Sprite2D = get_node_or_null("PickupIcon")
	if !is_instance_valid(sprite): # Do we need to create it?
		sprite      = Sprite2D.new()
		sprite.name = "PickupIcon"
		add_child(sprite)
	sprite.texture = item1.texture
	
	# Use item1 as needed
func _on_body_entered(body) -> void:
	if body.name == "Player":
		player_colliding = true
	
func _on_body_exited(body) -> void:
	if body.name == "Player":
		player_colliding = false
	
func _process(_delta: float):
	if Handmanager.Items.size() < 2 and Input.is_key_pressed(KEY_E) == true and player_colliding == true:
		Handmanager.addItem(item1)
		queue_free()
