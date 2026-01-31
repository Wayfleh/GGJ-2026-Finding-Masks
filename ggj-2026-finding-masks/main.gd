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
	mask_area.round_won.connect(_on_round_won)
	
func _on_round_won() -> void:
	var old := target_index
	while target_index == old:
		target_index = randi_range(0,6)
		
		game_timer.update_target_image()
		
		mask_area.reset_round()
	
