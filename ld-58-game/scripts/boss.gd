extends Node2D

const SPEED = 20
const acceleration = 1.5
const knockback = .75

var direction = -1
var velocity = 0

const max_hp = 12.0
var hp = max_hp

var dir_change = false
var can_attack: bool
var in_range: bool
var is_attacking: bool

@onready var enemy: Node2D = $"."
@onready var game_manager: Node = $"../../../game_manager"
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var fist: AnimatedSprite2D = $fist
@onready var player: CharacterBody2D = $"../../Player"
@onready var aggro_range: CollisionShape2D = $aggro_range/CollisionShape2D
@onready var attack_timer: Timer = $attack_timer
@onready var hurtbox: Area2D = $hurtbox
@onready var hitbox: CollisionShape2D = $hitbox/CollisionShape2D
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

func _init() -> void:
	can_attack = true
	is_attacking = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ((in_range == false or can_attack == false) and is_attacking == false):
		var pointer = (enemy.position - player.position).normalized()
		if pointer[0] < 0:
			hitbox.disabled = true
			direction = 1
			hitbox.position = Vector2(25, 3.5)
			hurtbox.position = Vector2(-10, 5)
		if pointer[0] > 0:
			hitbox.disabled = true
			direction = -1
			hitbox.position = Vector2(-25, 3.5)
			hurtbox.position = Vector2(10, 5)
		if (velocity < SPEED*2):
			velocity += acceleration * SPEED * delta
		position.x += 1 * velocity * acceleration * direction * delta
			
		if direction < 0:
			sprite_2d.play("move_left")
		if direction > 0:
			sprite_2d.play("move_right")
			
	if (in_range == true and can_attack == true and is_attacking == false):
		is_attacking = true
		velocity = 0
		if direction < 0:
			fist.offset = Vector2(-64, 0)
			fist.visible = true
			fist.play("fist_left")
			sprite_2d.play("hit_left")
			await get_tree().create_timer(.3).timeout
			hitbox.disabled = false
			await get_tree().create_timer(.2).timeout
			hitbox.disabled = true
			#if sprite_2d.animation_finished and fist.animation_finished:
			#fist.visible = false
			fist.visible = false
			can_attack = false
			is_attacking = false
			attack_timer.start()
						
		else:
			fist.offset = Vector2(64, 0)
			fist.visible = true
			fist.play("fist_right")
			sprite_2d.play("hit_right")
			await get_tree().create_timer(.3).timeout
			hitbox.disabled = false
			await get_tree().create_timer(.2).timeout
			hitbox.disabled = true
			#fist.visible = false
			#if sprite_2d.animation_finished and fist.animation_finished:
			fist.visible = false
			can_attack = false
			is_attacking = false
			attack_timer.start()
	
func bounce(pos_player: float):
	var distance = position.x - pos_player
	if (distance < 0):
		direction = 1
	if (distance > 0):
		direction = -1 
	velocity = -acceleration * SPEED * knockback
	
func take_dmg():
	hp -= 1
	progress_bar.set_value_no_signal(hp/max_hp*100)
	if (hp == 0):
		enemy.queue_free()
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_aggro_range_body_entered(body) -> void:
	if body.name == "Player":
		in_range = true

func _on_aggro_range_body_exited(body) -> void:
	if body.name == "Player":
		in_range = false

func _on_attack_timer_timeout() -> void:
	can_attack = true
	print("Timer: can attack true")

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		game_manager.decrease_health()
