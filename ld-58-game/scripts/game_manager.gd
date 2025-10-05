extends Node

@export var hearts: Array[Node]
@onready var timer: Timer = $death_timer
@onready var player: CharacterBody2D = $"../scene_objects/Player"
@onready var flash_animation: AnimationPlayer = $"../scene_objects/Player/flash_animation"

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
			timer.start()
		await get_tree().create_timer(.7).timeout
		iframes = false
	else:
		pass
		
func _on_timer_timeout():
		get_tree().reload_current_scene()
