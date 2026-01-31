class_name Mask extends Area2D

@onready var mask_index: int = -1
@onready var sprite : Sprite2D = $Sprite2D

static var mask_scene = preload("res://Scenes/mask.tscn")

#Creates a new mask
static func spawn(index: int) -> Mask:
	var new = mask_scene.instantiate()
	new.mask_index = index
	return new
