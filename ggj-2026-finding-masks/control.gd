extends Control
@export var mask_textures: Array[Texture2D]

@onready var prompt_label: Label = $VBoxContainer/Label
@onready var target_image: TextureRect = $VBoxContainer/TextureRect

func _ready() -> void:
	randomize()
	var target = mask_textures.pick_random()
	prompt_label.text = "Find this mask"
	target_image.texture = target
