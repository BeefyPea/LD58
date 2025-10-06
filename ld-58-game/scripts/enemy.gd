extends Node2D

const SPEED = 40
const acceleration = 1.5
const knockback = 1

var direction = 1
var stun = 10.0
var velocity = 0

const max_hp = 5
var hp = max_hp

@onready var enemy: Node2D = $"."
<<<<<<< HEAD
#@onready var sprite_2d: AnimatedSprite2D = $"../enemy2/Sprite2D"
=======
@onready var animated_sprite: AnimatedSprite2D = $Sprite2D
>>>>>>> main

@onready var ray_cast_left: RayCast2D = $RayCast_left
@onready var ray_cast_right: RayCast2D = $RayCast_right
@onready var ray_cast_bottom_left: RayCast2D = $RayCast_bottom_left
@onready var ray_cast_bottom_right: RayCast2D = $RayCast_bottom_right

@onready var ray_casts_right_aggro: Array = $aggro_ray_cast/ray_casts_right.get_children()
@onready var ray_casts_left_aggro: Array = $aggro_ray_cast/ray_casts_left.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (velocity < 40):
		velocity += acceleration * SPEED * delta
	position.x += 1 * velocity * acceleration * direction * delta
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.play("Left")
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.play("Right")
	if ray_cast_bottom_right.is_colliding() == false:
		direction = -1
		animated_sprite.play("Left")
	if ray_cast_bottom_left.is_colliding() == false:
		direction = 1
		animated_sprite.play("Right")
	for i in ray_casts_right_aggro:
		if i.is_colliding():
			direction = 1
			animated_sprite.play("Right")
	for i in ray_casts_left_aggro:
		if i.is_colliding():
			direction = -1
			animated_sprite.play("Left")
	
func bounce(pos_player: float):
	var distance = position.x - pos_player
	if (distance < 0):
		direction = 1
		animated_sprite.play("Right")
	if (distance > 0):
		direction = -1 
		animated_sprite.play("Left")
	velocity = -acceleration * SPEED * knockback
	
func take_dmg():
	hp -= 1
	if (hp == 0):
		enemy.queue_free()
