extends CanvasLayer

#@onready var grid_container = $GridContainer
@onready var grid_container: CanvasLayer = $"."
@onready var Player: CharacterBody2D = $"../scene_objects/Player"
@onready var game_manager: Node = $"../game_manager"

var shift = Vector2(0, -32)


func _ready():
	# Connect to the inventory's signal.
	# Now, whenever an item is added or removed, update_ui() is called.
	Handmanager.update_inventory.connect(update_ui)
	
	# Initial UI update.
	update_ui()
 
func update_ui():
	var slots = grid_container.get_children()
	var inventory_items = Handmanager.Items
	if inventory_items.size() > 0:
		for i in range(slots.size()):
			var slot = slots[i]
			if i < inventory_items.size() :
				# If there's an item for this slot, display it.
				var item = inventory_items[i]
				slot.get_node("TextureRect").texture = item.texture
				# (Add logic for label/quantity here)
			else:
				# Otherwise, clear the slot.
				slot.get_node("TextureRect").texture = null
				
func _physics_process(_float) -> void:
	var slots = grid_container.get_children()
	if Input.is_action_just_pressed("linkehand") == true and Handmanager.Items.size() > 0 :
		var Place_item = Handmanager.Items[0]
		var Place_pickup = preload("res://scenes/Pickup.tscn")
		var instance = Place_pickup.instantiate()
		instance.init(Place_item)
		instance.global_position = Player.global_position + shift
		get_tree().current_scene.add_child(instance)
		slots[0].get_node("TextureRect").texture = null
		Handmanager.delItem(Handmanager.Items[0])
		
		update_ui()
	
