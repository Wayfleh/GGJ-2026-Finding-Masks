extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = str(GlobalScoreTracker.score)
	pass # Replace with function body.
