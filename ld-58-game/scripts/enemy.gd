extends Node2D

const SPEED = 40

var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right_ground: RayCast2D = $RayCastRightGround
@onready var ray_cast_left_ground: RayCast2D = $RayCastLeftGround

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_right_ground.is_colliding() == false:
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_left_ground.is_colliding() == false:
		direction = 1
	position.x += direction * SPEED * delta
