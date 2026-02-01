extends Control

@onready var click_sfx: AudioStreamPlayer = $ClickSfx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	GlobalScoreTracker.score = 0
	print("Start Button!")
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
	
	


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
