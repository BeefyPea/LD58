extends Node2D

const SPEED = 40
var direction = 1

@onready var ray_cast_left: RayCast2D = $RayCast_left
@onready var ray_cast_right: RayCast2D = $RayCast_right
@onready var ray_cast_bottom_left: RayCast2D = $RayCast_bottom_left
@onready var ray_cast_bottom_right: RayCast2D = $RayCast_bottom_right


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 1 * SPEED * direction
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_bottom_right.is_colliding() == false:
		direction = -1
	if ray_cast_bottom_left.is_colliding() == false:
		direction = 1
		
