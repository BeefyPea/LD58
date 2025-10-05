extends CharacterBody2D

@export var speed = 750
@export var gravity = 2000
@export var jump_speed = -800
@export_range(0.0, 1.0) var friction = 0.3
@export_range(0.0 , 1.0) var acceleration = 0.1

@onready var hitbox_punch: CollisionShape2D = $hitbox_punch/CollisionShape2D

func _ready():
	add_to_group("player")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_punch: Area2D = $hitbox_punch

# punch shit
var is_punching = false
var punch_cd = 0.5
var punch_timer = 0.0
var last_dir = 1 #1 for right -1 for left

#death animation
var is_dead = false
var death_anm = "death"

func _physics_process(delta):
	
	if is_dead:
		return #stops all physics
	
	#punchcooldown
	if is_punching:
		punch_timer += delta
		if punch_timer >= punch_cd:
			is_punching = false
			punch_timer = 0.0
			hitbox_punch.disabled = true
		
	
	
	velocity.y += gravity * delta
	var dir = Input.get_axis("links", "rechts")
	
	
	# Update last_direction when moving

	if dir != 0:
		last_dir = dir
	#check the punchinput
	if Input.is_action_just_pressed("punch") and not is_punching:
		is_punching = true
		animated_sprite_2d.play("punch")
		hitbox_punch.disabled = false
		animated_sprite_2d.flip_h = true if last_dir < 0 else false
	
	#spriteflip
	if not is_punching:
		if dir > 0:
			animated_sprite_2d.flip_h = false
			area_punch.scale = Vector2(1.0, 1.0)
		elif dir < 0:
			animated_sprite_2d.flip_h = true
			area_punch.scale = Vector2(-1.0, 1.0)
	
	#player animations
	if is_punching:
		animated_sprite_2d.play("punch")
	else:
		if is_on_floor():
			if dir == 0:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("jump")	
	
	if is_on_floor():
		if dir != 0 :
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("oben") and is_on_floor():
		velocity.y = jump_speed

func death():
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	animated_sprite_2d.play("death")
