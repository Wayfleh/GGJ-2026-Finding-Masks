extends Control

@onready var label = $Label
@onready var timer = $Timer

@onready var prompt_label: Label = $Control/VBoxContainer/Label
@onready var target_image: TextureRect = $Control/VBoxContainer/TextureRect
@onready var main: Main = owner
func _ready() -> void:
	prompt_label.text = "Find this mask"
	target_image.texture = main.mask_sprites[main.target_index]
	timer.start()

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(delta):
	label.text = "%02d:%02d"% time_left_to_live()
