extends CharacterBody2D

@export var speed = 750
@export var gravity = 2000
@export var jump_speed = -800
@export_range(0.0, 1.0) var friction = 0.3
@export_range(0.0 , 1.0) var acceleration = 0.1

func _ready():
	add_to_group("player")

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("links", "rechts")
	if is_on_floor():
		if dir != 0 :
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("oben") and is_on_floor():
		velocity.y = jump_speed


#func _on_pickup_body_entered(body: Node2D) -> void:
#	pass # Replace with function body.
