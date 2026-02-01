extends Node
"""
Score tracker for the gameplay scene
"""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = str(GlobalScoreTracker.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func incrementAndUpdateScore() -> void:
	GlobalScoreTracker.score = GlobalScoreTracker.score + 1
	self.text = str(GlobalScoreTracker.score)
