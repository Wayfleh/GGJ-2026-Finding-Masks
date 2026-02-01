extends Control

@onready var score = $Score
@onready var high_score = $HighScore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalScoreTracker.check_high_score()
	score.text = str(GlobalScoreTracker.score)
	high_score.text = str(GlobalScoreTracker.high_score)



func _on_retry_pressed() -> void:
	GlobalScoreTracker.score = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
	
	


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
