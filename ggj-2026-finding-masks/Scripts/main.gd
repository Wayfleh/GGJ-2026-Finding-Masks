class_name Main extends Node2D

var mask_sprites: Array[CompressedTexture2D] = [
	preload("res://Art/PlaceHolder/mask_1.png"),
	preload("res://Art/PlaceHolder/mask_2.png"),
	preload("res://Art/PlaceHolder/mask_3.png")]

func _ready() -> void:
	mask_manager(10, 1)
#this will spawn masks at random positions around the map
func mask_manager(num: int, mask_index: int) -> void:
	for i in range(num):
		var curr_index = randi_range(1, 3)
		var mask = Mask.spawn(curr_index)
		add_child(mask)
		mask.sprite.texture = mask_sprites[curr_index - 1]
		mask.global_position.x = randi_range(80, 1840)
		mask.global_position.y = randi_range(80, 1000)
	
func mouse_enters_mask(mask_index: int) -> void:
	pass
	
