extends Node

@onready var itemarea = get_node_or_null("Itemarea")
@onready var area = $"."

@export var npc:NPC = NPC.new()
@export var Itemgot = false
var player_colliding = false
var item_colliding = false

signal itemgot

	
func init(npc1):
	npc.dialog = npc1.dialog
	npc.Itemneed = npc1.Itemneed
	print(npc.Itemneed)
	npc.NPCname= npc1.NPCname
	#npc.texture = npc1.texture
	var sprite: Sprite2D = get_node_or_null("NPCsprite")
	if !is_instance_valid(sprite): # Do we need to create it?
		sprite      = Sprite2D.new()
		sprite.name = "NPCsprite"
		add_child(sprite)
	sprite.texture = npc1.texture
	
func _on_body_entered(body) -> void:
	print(body.name)
	if body.name == "Player":
		player_colliding = true

func _on_itemarea_area_entered(area: Area2D) -> void:
	if area.name == "Pickup":
		print(npc.Itemneed)
		if area.item1.itemname == npc.Itemneed:
			item_colliding = true
			itemgot.emit()
			area.queue_free()

	
func _on_body_exited(body) -> void:
	if body.name == "Player":
		player_colliding = false




func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("rechtehand") and player_colliding == true:
		Dialogmanager.startdialog(area.global_position, npc.dialog)
