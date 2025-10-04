extends Area2D
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"


func _on_body_entered(player):
	if player.is_in_group("player"):
		Engine.time_scale = 0.5
		print("uhm yeah uhhhhh you dead :/")
		player.death()
		timer.start()



func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
