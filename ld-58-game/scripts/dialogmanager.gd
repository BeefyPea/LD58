extends Node

@onready var textbox_scene = preload("res://scenes/textbox.tscn")
var Dialog_lines: Array[String] = []
var current_dialog_line = 0

var textbox
var textbox_positon: Vector2
var is_dialog_active = false
var can_advance_line = false 

func startdialog(position: Vector2, lines: Array[String]):
	if is_dialog_active:
		return
		
	Dialog_lines = lines
	textbox_positon = position
	_show_textbox()
	is_dialog_active = true
	
func _show_textbox():
	textbox = textbox_scene.instantiate()
	textbox.finished_displaying.connect(_on_textbox_finished_displaying)
	get_tree().root.add_child(textbox)
	textbox.global_postion = textbox_positon
	textbox.display_text(Dialog_lines[current_dialog_line])
	can_advance_line = false

func _on_textbox_finished_displaying():
	can_advance_line = true
	
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("dialogweiter") && is_dialog_active && can_advance_line):
		textbox.queue_free()
		
		current_dialog_line += 1
		if current_dialog_line >= Dialog_lines.size():
			is_dialog_active = false
			current_dialog_line = 0
			return
		_show_textbox()
