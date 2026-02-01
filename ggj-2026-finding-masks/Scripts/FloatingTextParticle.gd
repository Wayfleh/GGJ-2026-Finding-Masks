extends Control
"""
1. move upwards for some amount of time
2. Disappear when timer is done.
"""

@export var timeUntilDestroy = 2.0
var timeElapsed = 0
@export var floatSpeed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	floatUpwardsAtSpeed(floatSpeed, delta)
	timeElapsed = timeElapsed + delta
	if timeElapsed >= timeUntilDestroy:
		queue_free()
	pass
	

func floatUpwardsAtSpeed(speed: float, delta: float):
	# Upwards on the screen is a negative Y
	position.y = position.y - (speed * delta)
	pass
