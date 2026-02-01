class_name GameMain extends Node

#Every node that gets sprites gets it from Main
#so that target mask matches from each node
#Currently that is timer.gd and mask_area.gd
@export var mask_sprites: Array[Texture2D]

var target_index: int = randi_range(0, mask_sprites.size() - 1)

@onready var mask_area: MaskArea = $MaskArea
@onready var game_timer = $TimerArea
@onready var scoreCounter: Label = $ScoreCounter

@onready var level = 0
@onready var curr_thresh = 0
@export var max_threshold = 5
@export var max_level = 10
@export var difficulty_factor = 2

func _ready() -> void:
	mask_area.time_delta.connect(game_timer.apply_time_delta)
	mask_area.round_won.connect(_on_round_won)
	game_timer.time_up.connect(_on_time_up)

func _on_round_won() -> void:
	var old : = target_index
	while target_index == old:
		target_index = randi_range(0,6)
		
		game_timer.update_target_image()
		
		mask_area.reset_round()
		
		scoreCounter.incrementAndUpdateScore()
		target_index = randi_range(0, mask_sprites.size() - 1)
	
	curr_thresh += 1
	if curr_thresh >= max_threshold and level < max_level:
		level += 1
		curr_thresh = 0
		
	
	game_timer.update_target_image()
	
	mask_area.reset_round()

func _on_time_up() -> void:
	mask_area.set_process(false)
	game_timer.set_process(false)
	game_timer.stop_timer()
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
