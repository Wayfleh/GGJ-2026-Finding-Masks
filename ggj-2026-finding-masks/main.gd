class_name GameMain extends Node

#Every node that gets sprites gets it from Main
#so that target mask matches from each node
#Currently that is timer.gd and mask_area.gd
@export var mask_sprites: Array[Texture2D]

var target_index: int = randi_range(0, 6)

@onready var mask_area: MaskArea = $MaskArea
@onready var game_timer = $TimerArea

func _ready() -> void:
	mask_area.time_delta.connect(game_timer.apply_time_delta)
	
