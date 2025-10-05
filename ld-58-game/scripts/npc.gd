extends Area2D

@onready var area: Area2D = $"."
var player_colliding = false
@export var npc: NPC

func _ready() -> void:
	# Create the NPC instance and configure it
	npc = NPC.new()
	npc.dialog = ["Griechischer Wein ist so \n wie das Blut der Erde",
				"Komm, schenk dir ein",
				"Und wenn ich dann traurig werde,\n liegt es daran",
				"Dass ich immer träume von daheim,\n du musst verzeih'n",
				"Griechischer Wein und die altvertrauten Lieder",
				"Schenk noch mal ein",
				"Denn ich fühl die Sehnsucht wieder, in dieser Stadt",
				"Werd' ich immer nur ein Fremder sein und allein"]
	npc.NPCname = "npc1.NPCname"
	npc.texture = preload("res://icon.svg")
	
func init(npc1):
	npc = npc1
	
func _on_body_entered(body) -> void:
	if body.name == "Player":
		player_colliding = true

func _on_body_exited(body) -> void:
	if body.name == "Player":
		player_colliding = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("rechtehand") and player_colliding == true:
		Dialogmanager.startdialog(area.global_position, npc.dialog)
