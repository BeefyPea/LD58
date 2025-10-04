extends CharacterBody2D

@export var speed = 750
@export var gravity = 2000
@export var jump_speed = -800
@export_range(0.0, 1.0) var friction = 0.3
@export_range(0.0 , 1.0) var acceleration = 0.1

func _ready():
	add_to_group("player")
	
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	
	velocity.y += gravity * delta
	#gets input direction
	var dir = Input.get_axis("links", "rechts")
	#spriteflip
	if dir > 0:
		animated_sprite_2d.flip_h = false
	elif dir < 0:
		animated_sprite_2d.flip_h = true
	
	#player animations
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
