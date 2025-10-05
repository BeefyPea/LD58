extends MarginContainer

@onready var label:Label = $NinePatchRect/MarginContainer/Label
@onready var timer: Timer = $Lettertimer

const MAX_WIDTH = 128

var text = ""
var text_index = 0

var letter_time = 0.2
var punctuation_time = 0.1
var space_time = 0.1

signal finish_displaying

func display_text(text_to_display):
	text = text_to_display
	label.text = text_to_display
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized 
	custom_minimum_size.y = size.y
	global_position.x -= size.x/2
	global_position.y -= size.y +24
	
	label.text = ""
	_display_letter()
	
func _display_letter():
	label.text = text[text_index] 
	text_index += 1
	if text_index > text.size():
		finish_displaying.emit()
		return
		
	match text[text_index]:
		" ":
			timer.start(space_time)
		".,:!?'":
			timer.start(punctuation_time)
		_:
			timer.start(letter_time)
	


func _on_lettertimer_timeout() -> void:
	print("lettertimeout")
	_display_letter()
