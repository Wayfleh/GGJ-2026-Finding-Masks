extends Control

@onready var label = $Label
@onready var timer = $Timer

@onready var target_image: TextureRect = $TextureRect
@onready var main: Main = owner

@export var time: int 

#Grabs the target image from the main node's mask_sprites array
#using its target index
func _ready() -> void:
	target_image.texture = main.mask_sprites[main.target_index]
	timer.start(time)

#calculating the number of minutes and seconds left in timer
func time_left_to_live() -> Array[int]:
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

#update timer
func _process(delta):
	label.text = "%02d:%02d"% time_left_to_live()
