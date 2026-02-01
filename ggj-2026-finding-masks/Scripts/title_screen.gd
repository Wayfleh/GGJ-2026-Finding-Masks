extends Control

@onready var click_sfx: AudioStreamPlayer = $ClickSfx
@onready var title_ui: Control = $TitleUI
@onready var credits_ui: Control = $Credits
@onready var button_click: AudioStreamPlayer = $buttonClick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_ui.visible = true
	credits_ui.visible = false
	
	var back_btn := credits_ui.get_node_or_null("BackButton")
	if back_btn:
		back_btn.pressed.connect(_on_credits_back_pressed)
	else:
		push_error("BackButton not foud")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	GlobalScoreTracker.score = 0
	print("Start Button!")
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

func _on_credits_button_pressed() -> void:
	button_click.play()
	title_ui.visible = false
	credits_ui.visible = true


func _on_credits_back_pressed() -> void:
	button_click.play()
	credits_ui.visible = false
	title_ui.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
