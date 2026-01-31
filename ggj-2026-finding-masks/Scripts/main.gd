class_name Main extends Node2D

var mask_sprites: Array[CompressedTexture2D] = [
	preload("res://Art/PlaceHolder/mask_1.png"),
	preload("res://Art/PlaceHolder/mask_2.png"),
	preload("res://Art/PlaceHolder/mask_3.png")]

var mask_cache : Array[Mask] = []

func _ready() -> void:
	#mask_manager(10, 1)
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	if mask_cache.is_empty():
		return
	print(mask_cache[0])
	#If player left clicks on one or more masks
#this will spawn masks at random positions around the map
func mask_manager(num: int, mask_index: int) -> void:
	for i in range(num):
		var curr_index = randi_range(1, 3)
		var mask = Mask.spawn(curr_index)
		add_child(mask)
		mask.mouse_entered.connect(mouse_enters_mask.bind(mask))
		mask.mouse_exited.connect(mouse_exits_mask.bind(mask))
		mask.sprite.texture = mask_sprites[curr_index - 1]
		mask.global_position.x = randi_range(80, 1840)
		mask.global_position.y = randi_range(80, 1000)
	
func mouse_enters_mask(mask: Mask) -> void:
	mask_cache.push_front(mask)

func mouse_exits_mask(mask: Mask) -> void:
	mask_cache.erase(mask)
