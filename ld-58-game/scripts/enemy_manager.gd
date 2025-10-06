extends Node

@onready var enemy: Node = $"."
@export var boss_scene: PackedScene
@onready var boss_spawnpoint: Marker2D = $boss_spawnpoint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_countdown_timeout() -> void:
	var boss_scene = preload("res://scenes/boss.tscn")
	var boss1 = boss_scene.instantiate()
	boss1.global_position = boss_spawnpoint.global_position
	add_child(boss1)
