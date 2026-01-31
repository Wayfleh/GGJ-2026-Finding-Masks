class_name MaskArea extends Control

var mask_cache : Array[Mask] = []
@onready var target_mask : Mask = null
@onready var found_target : bool = false
@onready var main: GameMain = owner

signal level_complete

func _ready() -> void:
	mask_manager(10, 1)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		if mask_cache.is_empty() || found_target == true:
			return
		#if the mouse is hovering over the correct mask when player clicks,
		#mask is found
		if mask_cache.has(target_mask):
			print("target found!!!")
			found_target = true
			
			#TODO - connect this signal to a new function here or in Main
			#that switches the active scene to the end scene
			#then later we can have it change levels or something
			level_complete.emit()
	
#this will spawn masks at random positions around the map
#spawns n-1 random masks, then spawns the target mask separately
func mask_manager(num: int, target_index: int) -> void:
	
	for i in range(num -1):
		var curr_index = main.target_index
		while curr_index == main.target_index:
			curr_index = randi_range(0, 6)
		_make_mask(curr_index)
	
	#sets the target_mask variable while putting it on the screen
	#this way the game can reference it directly from the cache
	target_mask = _make_mask(main.target_index)
		

#helper function for making a mask and putting it in a random place
func _make_mask(index: int) -> Mask:
	var mask = Mask.spawn(index)
	#adds the mask as a child of the Mask Area
	add_child(mask)
	
	#connects the mouse entering and exiting signals to the functions below
	mask.mouse_entered.connect(mouse_enters_mask.bind(mask))
	mask.mouse_exited.connect(mouse_exits_mask.bind(mask))
	
	#sets texture
	mask.sprite.texture = main.mask_sprites[index]
	
	#places the mask in a random position within the box
	#the radius of the collider is 90px
	mask.global_position.x = randi_range(278 + 90, 1364 - 90)
	mask.global_position.y = randi_range(312 + 90, 1080 - 90)
	
	return mask

#hovering over a mask adds it to an array
#this is a reference to the object itself,
#so you can do operations on it if you need
func mouse_enters_mask(mask: Mask) -> void:
	mask_cache.push_front(mask)
#leaving the mask's collider removes it from the cache
func mouse_exits_mask(mask: Mask) -> void:
	mask_cache.erase(mask)
