class_name Main extends Node

#Every node that gets sprites gets it from Main
#so that target mask matches from each node
#Currently that is timer.gd and mask_area.gd
@export var mask_sprites: Array[Texture2D]

var target_index: int = randi_range(0, 6)
