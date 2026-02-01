extends Node

@onready var score = 0
@onready var high_score = 0

func check_high_score() -> void:
	if score > high_score:
		high_score = score
