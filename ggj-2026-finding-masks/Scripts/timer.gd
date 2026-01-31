extends Control

@onready var label = $Label
@onready var timer = $Timer

@onready var target_image: TextureRect = $TextureRect
@onready var main: Main = owner

func _ready() -> void:
	target_image.texture = main.mask_sprites[main.target_index]
	timer.start(90)

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(delta):
	label.text = "%02d:%02d"% time_left_to_live()
