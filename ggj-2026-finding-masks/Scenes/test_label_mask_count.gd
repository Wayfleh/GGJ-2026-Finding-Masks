extends Label

@onready var mask_area = %MaskArea

func _process(delta: float) -> void:
	text = str(mask_area.get_child_count())
