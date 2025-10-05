extends Area2D

@onready var game_manager: Node = $"../../../../game_manager"
@onready var enemy: Node2D = $".."

func _on_body_entered(body):
	game_manager.decrease_health()
	var x_body_pos = body.position.x
	enemy.bounce(x_body_pos)
