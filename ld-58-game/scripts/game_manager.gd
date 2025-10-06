extends Node

@export var hearts: Array[Node]
@onready var timer: Timer = $death_timer
@onready var player: CharacterBody2D = $"../scene_objects/Player"
@onready var flash_animation: AnimationPlayer = $"../scene_objects/Player/flash_animation"

@onready var pickup: Area2D = $"../scene_objects/obst"
@onready var pickup_2: Area2D = $"../scene_objects/tasse"
@onready var pickup_3: Area2D = $"../scene_objects/unterhose"
@onready var pickup_4: Area2D = $"../scene_objects/ratte"

@onready var penner: Area2D = $"../scene_objects/Penner"
@onready var lonk: Area2D = $"../scene_objects/Lonk"
@onready var opa: Area2D = $"../scene_objects/Opa"


#items init:

var texture_tasse = load("res://assets/sprites/mug.png") as Texture2D
var texture_ratte = load("res://assets/sprites/ratte.png") as Texture2D
var texture_obst = load("res://assets/sprites/obst.png") as Texture2D
var texture_unterhose = load("res://assets/sprites/unterhose.png") as Texture2D

@onready var penner_ohne: AnimatedSprite2D = $"../scene_objects/Penner/Penner_ohne"
@onready var lonk_sprite: AnimatedSprite2D = $"../scene_objects/Lonk/LonkSprite"
@onready var opa_sprite: AnimatedSprite2D = $"../scene_objects/Opa/OpaSprite"




var item_init = Item.new()
var npc_init: NPC

func _ready():
	penner_ohne.play("default")
	lonk_sprite.play("default")
	opa_sprite.play("default")
	
	npc_init = NPC.new()
	item_init.texture = texture_obst
	item_init.itemname = "obst"
	pickup.init(item_init) 
	
	item_init.texture = texture_tasse
	item_init.itemname = "tasse"
	pickup_2.init(item_init)

	item_init.texture = texture_unterhose
	item_init.itemname = "unterhose"
	pickup_3.init(item_init)
	
	item_init.texture = texture_ratte
	item_init.itemname = "ratte"
	pickup_4.init(item_init)
	
	npc_init.texture = lonk_sprite
	npc_init.Itemneed = "tasse"
	npc_init.dialog= ["I can't seem to find any pots","I wonder if there is somethin else \n to smash?", "Have you heard that\n they're coming?","Dont know who \n to be honest", "I only heard they're coming"]
	npc_init.NPCname = "Lonk"
	lonk.init(npc_init)
	
	npc_init.texture = opa_sprite
	npc_init.Itemneed = "obst"
	npc_init.dialog= ["What a wonderful view!","Oh how much I would enjoy\n a bowl of fruit", "I read in the paper \nthat they're coming","Don't know who though"]
	npc_init.NPCname = "Opa"
	opa.init(npc_init)
	
	npc_init.texture = penner_ohne
	npc_init.Itemneed = "unterhose"
	npc_init.dialog= ["THEY'RE COMING!","I SAW IT!", "THEY'RE COMING!","i am also quite cold"]
	npc_init.NPCname = "Penner"
	penner.init(npc_init)

var hp = 3
var iframes = false

func decrease_health():
	if (iframes == false):
		hp -= 1
		iframes = true
		flash_animation.play("flash")
		for h in range(0, hp+1):
			if (h < hp):
				hearts[h].show()
			if (h >= hp):
				hearts[h].hide()
		if (hp == 0):
			Engine.time_scale = 0.5
			print("uhm yeah uhhhhh you dead :/")
			player.death()
			timer.start()
		await get_tree().create_timer(.7).timeout
		iframes = false
	else:
		pass
		
func _on_timer_timeout():
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()


func _on_hitbox_punch_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_dmg(area)

func _on_penner_itemgot() -> void:
	npc_init.texture = penner_ohne
	penner_ohne.play("mit")
	npc_init.Itemneed = "unterhose"
	npc_init.dialog= ["THEY'RE COMING!","I SAW IT!", "THEY'RE COMING!","im not as cold now", "thanks","BUT LISTEN","SOOOON","SOON THEY'LL ARRIVE!"]
	npc_init.NPCname = "Penner"
	penner.init(npc_init)

func _on_lonk_itemgot() -> void:
	npc_init.texture = lonk_sprite
	npc_init.Itemneed = "XXX"
	npc_init.dialog= ["What a wonderful mug!","I shall smash this soon enough!","Also","They should be here \n very very soon","Like","Really really soon"]
	npc_init.NPCname = "Lonk"
	lonk.init(npc_init)

func _on_opa_itemgot() -> void:
	npc_init.texture = opa_sprite
	npc_init.Itemneed = "obst"
	npc_init.dialog= ["Oh thank you my friend!", "I'll enjoy these fruits!","Oh and I really do \n wonder who's coming"]
	npc_init.NPCname = "Opa"
	opa.init(npc_init)
