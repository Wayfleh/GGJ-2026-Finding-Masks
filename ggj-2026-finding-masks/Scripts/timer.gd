extends Control

@onready var label = $Label
@onready var timer = $Timer

@onready var target_image: TextureRect = $TextureRect
@onready var main: GameMain = owner

@export var time: int = 120
signal time_up

func _on_timer_timeout() -> void:
	time_up.emit()
	
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

func apply_time_delta(seconds: int) -> void:
	var new_time_left : float = timer.time_left + float(seconds)
	new_time_left = max(0.0, new_time_left)
	
	timer.stop()
	
	if new_time_left <= 0.0:
		time_up.emit()
	else:
		timer.start(new_time_left)
	
func update_target_image() ->void:
		target_image.texture = main.mask_sprites[main.target_index]
	

func stop_timer() -> void:
	timer.stop()
