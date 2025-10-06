extends Node

@export var hearts: Array[Node]
@onready var timer: Timer = $death_timer
@onready var player: CharacterBody2D = $"../scene_objects/Player"
@onready var flash_animation: AnimationPlayer = $"../scene_objects/Player/flash_animation"

@onready var pickup: Area2D = $"../scene_objects/pickup"
@onready var pickup_2: Area2D = $"../scene_objects/pickup2"
@onready var pickup_3: Area2D = $"../scene_objects/pickup3"
@onready var pickup_4: Area2D = $"../scene_objects/pickup4"

#items init:

var texture_tasse = load("res://assets/sprites/mug.png") as Texture2D
var texture_ratte = load("res://assets/sprites/ratte.png") as Texture2D
var texture_obst = load("res://assets/sprites/obst.png") as Texture2D
var texture_unterhose = load("res://assets/sprites/unterhose.png") as Texture2D

var item_init = Item.new()

func _ready():
	item_init.texture = texture_obst
	pickup.init(item_init) 
	
	item_init.texture = texture_tasse
	pickup_2.init(item_init)

	item_init.texture = texture_unterhose
	pickup_3.init(item_init)
	
	item_init.texture = texture_ratte
	pickup_4.init(item_init)

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
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_hitbox_punch_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_dmg(area)
