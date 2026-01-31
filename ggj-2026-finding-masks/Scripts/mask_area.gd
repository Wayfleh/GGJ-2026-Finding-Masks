class_name MaskArea extends Node2D


var mask_cache : Array[Mask] = []
@onready var target_mask : Mask = null
@onready var found_target : bool = false
@onready var main: Main = owner

signal level_complete

func _ready() -> void:
	mask_manager(10, 1)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		if mask_cache.is_empty() || found_target == true:
			return
		if mask_cache.has(target_mask):
			print("target found!!!")
			found_target = true
			level_complete.emit()
	
#this will spawn masks at random positions around the map
func mask_manager(num: int, target_index: int) -> void:
	for i in range(num -1):
		var curr_index = main.target_index
		while curr_index == main.target_index:
			curr_index = randi_range(0, 6)
		_make_mask(curr_index)
	target_mask = _make_mask(main.target_index)
		

#helper function for making a mask and putting it in a random place
func _make_mask(index: int) -> Mask:
	var mask = Mask.spawn(index)
	add_child(mask)
	mask.mouse_entered.connect(mouse_enters_mask.bind(mask))
	mask.mouse_exited.connect(mouse_exits_mask.bind(mask))
	mask.sprite.texture = main.mask_sprites[index]
	mask.global_position.x = randi_range(80, 1840)
	mask.global_position.y = randi_range(80, 1000)
	return mask
	
func mouse_enters_mask(mask: Mask) -> void:
	mask_cache.push_front(mask)

func mouse_exits_mask(mask: Mask) -> void:
	mask_cache.erase(mask)
