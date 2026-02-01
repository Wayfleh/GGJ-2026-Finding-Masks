class_name MaskArea extends Control

var mask_cache : Array[Mask] = []
var time_inc : int = 2
var time_dec : int = -15
@onready var target_mask : Mask = null
@onready var found_target : bool = false
@onready var main: GameMain = owner

signal round_won
signal time_delta(seconds: int)

var clickCorrectTextParticle: PackedScene = preload("res://Scenes/ClickCorrectTextParticle.tscn")
var clickWrongTextParticle: PackedScene = preload("res://Scenes/ClickWrongTextParticle.tscn")

func _ready() -> void:
	mask_manager(10)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		if mask_cache.is_empty() || found_target == true:
			return
		#if the mouse is hovering over the correct mask when player clicks,
		#mask is found
		var clicked_mask: Mask = mask_cache[0]
		
		if IsTargetMaskInMaskCache(target_mask, mask_cache):
			print("target found!!!")
			time_delta.emit(time_inc)
			var particle = clickCorrectTextParticle.instantiate()
			CenterControlNodeOnMouse(particle)
			add_child(particle)
			#Simply create and set the position of the particle.
			# The particle is scripted to delete itself via FloatingTextParticle.gd
			round_won.emit()
		else:
			var particle = clickWrongTextParticle.instantiate()
			CenterControlNodeOnMouse(particle)
			add_child(particle)
			print("wrong mask!")
			time_delta.emit(time_dec)
			
			#TODO - connect this signal to a new function here or in Main
			#that switches the active scene to the end scene
			#then later we can have it change levels or something
	
#this will spawn masks at random positions around the map
#spawns n-1 random masks, then spawns the target mask separately
func mask_manager(num: int) -> void:
	
	for i in range(num -1):
		var curr_index = main.target_index
		while curr_index == main.target_index:
			curr_index = randi_range(0, main.mask_sprites.size() - 1)
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

#sets the clear mask to true clears the masks off screen and then sets mask target back to false for next round
func reset_round() -> void:
	found_target = true
	clear_masks()
	await get_tree().process_frame
	found_target = false
	mask_manager(10 + (main.level * 2))
	
#helper function for reset_round that clears all masks in screen
func clear_masks() -> void:
	for child in get_children():
		if child is Mask:
			child.queue_free()
	mask_cache.clear()
	

func IsTargetMaskInMaskCache(target: Mask, cache:Array[Mask]) -> bool:
	for mask: Mask in cache:
		if mask == target:
			return true
	return false

func CenterControlNodeOnMouse(object: Control):
	var mousePos: Vector2 = get_local_mouse_position()
	object.global_position.x = mousePos.x - (object.size.x / 2)
	object.global_position.y = mousePos.y - (object.size.y / 2)
	print("label position: " + str(object.global_position))
	print("mousePos: " + str(mousePos))
	print("object.size: " + str(object.size))
	pass
