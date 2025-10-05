extends Area2D

@onready var area: Area2D = $"."
@onready var npc1 = NPC.new()
@onready var player = get_node("/root/Main/Player")


func _ready():
	npc1.dialog = ["Du bist echt", "wirklich toll drin", "meine Eier zu lecken"]
	npc1.NPCname = "Georg"
	npc1.texture = preload("res://icon.svg")

func _process(delta: float) -> void:
	area.body_entered(player) and Input.is_key_pressed(KEY_E):
		print("testtest")
		Dialogmanager.startdialog(npc1.global_position, npc1.dialog)
