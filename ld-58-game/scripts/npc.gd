extends Area2D

@onready var area: Area2D = $"."
var npc: NPC  # We'll initialize this in _ready()

func _ready() -> void:
	# Create the NPC instance and configure it
	npc = NPC.new()
	npc.dialog = ["test"]
	npc.NPCname = "npc1.NPCname"
	npc.texture = preload("res://icon.svg")
	

#func _process(_delta: float) -> void:
#	if Input.is_key_pressed(KEY_E) and area.has_overlapping_bodies():
#		print("rede")
#		Dialogmanager.startdialog(area.global_position, npc.dialog)

func _on_body_entered(body):
	print("collided")
